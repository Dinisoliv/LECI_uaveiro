#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/unistd.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
#include "freertos/queue.h"

#include "esp_log.h"
#include "esp_err.h"

#include "esp_vfs_fat.h"
#include "sdmmc_cmd.h"
#include "driver/spi_master.h"
#include "driver/i2c_master.h"

/* ----------------------- DEFINITIONS ----------------------- */
#define MOUNT_POINT "/sdcard"
static const char *TAG_SD  = "sdlog";
static const char *TAG_DHT = "DHT20";

/* SD Pins from menuconfig */
#define PIN_NUM_MISO  CONFIG_EXAMPLE_PIN_MISO
#define PIN_NUM_MOSI  CONFIG_EXAMPLE_PIN_MOSI
#define PIN_NUM_CLK   CONFIG_EXAMPLE_PIN_CLK
#define PIN_NUM_CS    CONFIG_EXAMPLE_PIN_CS

/* I2C + DHT20 */
#define I2C_MASTER_SCL_IO      7
#define I2C_MASTER_SDA_IO      6
#define I2C_MASTER_NUM         I2C_NUM_0
#define I2C_MASTER_FREQ_HZ     100000
#define I2C_MASTER_TIMEOUT_MS  1000

#define DHT20_ADDR     0x38
#define DHT20_CMD_TRIG 0xAC
#define DHT20_ARG1     0x33
#define DHT20_ARG2     0x00
#define DHT20_DELAY_MS 100

/* ----------------------- GLOBAL HANDLES ----------------------- */
i2c_master_bus_handle_t bus_handle;
i2c_master_dev_handle_t dev_handle;
sdmmc_card_t *sdcard;

SemaphoreHandle_t sd_mutex;
QueueHandle_t sensor_queue;

/* Estrutura enviada pela Task do sensor para a Task do SD */
typedef struct {
    uint64_t time_ms;
    float temperature;
    float humidity;
    int counter;
} sensor_data_t;

/* ----------------------- I2C + DHT20 ----------------------- */
static void i2c_master_init(void)
{
    i2c_master_bus_config_t bus_cfg = {
        .i2c_port = I2C_MASTER_NUM,
        .sda_io_num = I2C_MASTER_SDA_IO,
        .scl_io_num = I2C_MASTER_SCL_IO,
        .clk_source = I2C_CLK_SRC_DEFAULT,
        .glitch_ignore_cnt = 7,
        .flags.enable_internal_pullup = true,
    };
    ESP_ERROR_CHECK(i2c_new_master_bus(&bus_cfg, &bus_handle));

    i2c_device_config_t dev_cfg = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = DHT20_ADDR,
        .scl_speed_hz = I2C_MASTER_FREQ_HZ,
    };
    ESP_ERROR_CHECK(i2c_master_bus_add_device(bus_handle, &dev_cfg, &dev_handle));
}

static esp_err_t dht20_read_raw(uint8_t *data)
{
    uint8_t cmd[3] = {DHT20_CMD_TRIG, DHT20_ARG1, DHT20_ARG2};
    ESP_ERROR_CHECK(i2c_master_transmit(
        dev_handle, cmd, 3, I2C_MASTER_TIMEOUT_MS / portTICK_PERIOD_MS));

    vTaskDelay(pdMS_TO_TICKS(DHT20_DELAY_MS));

    return i2c_master_receive(
        dev_handle, data, 7, I2C_MASTER_TIMEOUT_MS / portTICK_PERIOD_MS);
}

static void dht20_convert(float *T, float *H, uint8_t *d)
{
    uint32_t raw_h = ((uint32_t)d[1] << 12) | ((uint32_t)d[2] << 4) | (d[3] >> 4);
    uint32_t raw_t = ((uint32_t)(d[3] & 0x0F) << 16) | ((uint32_t)d[4] << 8) | d[5];

    *H = (raw_h * 100.0f) / 1048576.0f;
    *T = ((raw_t * 200.0f) / 1048576.0f) - 50.0f;
}

/* ----------------------- SD CARD FUNCTIONS ----------------------- */
static void sd_write_header(void)
{
    xSemaphoreTake(sd_mutex, portMAX_DELAY);

    FILE *f = fopen("/sdcard/log.txt", "w");
    if (f) {
        fprintf(f, "time_ms,counter,temperature,humidity\n");
        fclose(f);
    }

    xSemaphoreGive(sd_mutex);
}

static void sd_append_record(sensor_data_t *d)
{
    char line[128];
    snprintf(line, sizeof(line),
             "%llu,%d,%.2f,%.2f\n",
             d->time_ms, d->counter, d->temperature, d->humidity);

    xSemaphoreTake(sd_mutex, portMAX_DELAY);

    FILE *f = fopen("/sdcard/log.txt", "a");
    if (f) {
        fprintf(f, "%s", line);
        fclose(f);
    }

    xSemaphoreGive(sd_mutex);

    ESP_LOGI(TAG_SD,
             "Logged: time=%llu ms, counter=%d, temp=%.2f C, hum=%.2f %%",
             d->time_ms, d->counter, d->temperature, d->humidity);
}

/* ----------------------- TASK 1: SENSOR ----------------------- */
void sensor_task(void *arg)
{
    uint8_t raw[7];
    int counter = 0;

    while (1) {
        if (dht20_read_raw(raw) == ESP_OK && !(raw[0] & 0x80)) {
            float T, H;
            dht20_convert(&T, &H, raw);

            sensor_data_t data = {
                .time_ms = xTaskGetTickCount() * portTICK_PERIOD_MS,
                .temperature = T,
                .humidity = H,
                .counter = counter++
            };

            xQueueSend(sensor_queue, &data, portMAX_DELAY);
        }

        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}

/* ----------------------- TASK 2: SD LOGGER ----------------------- */
void sd_task(void *arg)
{
    sensor_data_t data;

    while (1) {
        if (xQueueReceive(sensor_queue, &data, portMAX_DELAY)) {
            sd_append_record(&data);
        }
    }
}

/* ----------------------- app_main ----------------------- */
void app_main(void)
{
    /* --- Initialize SD card --- */
    sdmmc_host_t host = SDSPI_HOST_DEFAULT();

    spi_bus_config_t bus_cfg = {
        .mosi_io_num = PIN_NUM_MOSI,
        .miso_io_num = PIN_NUM_MISO,
        .sclk_io_num = PIN_NUM_CLK,
        .quadwp_io_num = -1,
        .quadhd_io_num = -1,
        .max_transfer_sz = 4000,
    };
    ESP_ERROR_CHECK(spi_bus_initialize(host.slot, &bus_cfg, SDSPI_DEFAULT_DMA));

    sdspi_device_config_t slot_cfg = SDSPI_DEVICE_CONFIG_DEFAULT();
    slot_cfg.gpio_cs = PIN_NUM_CS;
    slot_cfg.host_id = host.slot;

    esp_vfs_fat_sdmmc_mount_config_t mount_config = {
        .format_if_mount_failed = false,
        .max_files = 5,
        .allocation_unit_size = 16 * 1024
    };

    ESP_ERROR_CHECK(esp_vfs_fat_sdspi_mount(
        MOUNT_POINT, &host, &slot_cfg, &mount_config, &sdcard));
    ESP_LOGI(TAG_SD, "Mounted. Card: %s", sdcard->cid.name);

    /* --- Create mutex and queue --- */
    sd_mutex = xSemaphoreCreateMutex();
    sensor_queue = xQueueCreate(10, sizeof(sensor_data_t));

    /* --- SD header --- */
    sd_write_header();

    /* --- Initialize I2C --- */
    i2c_master_init();
    ESP_LOGI(TAG_DHT, "I2C initialized for DHT20");

    /* --- Create tasks --- */
    xTaskCreate(sensor_task, "sensor_task", 4096, NULL, 5, NULL);
    xTaskCreate(sd_task, "sd_task", 4096, NULL, 5, NULL);
}
