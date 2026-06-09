#include <stdio.h>
#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "driver/i2c_master.h"

/* ---- I2C configuration ---- */
#define I2C_MASTER_SCL_IO           7
#define I2C_MASTER_SDA_IO           6
#define I2C_MASTER_NUM              I2C_NUM_0
#define I2C_MASTER_FREQ_HZ          100000
#define I2C_MASTER_TX_BUF_DISABLE   0
#define I2C_MASTER_RX_BUF_DISABLE   0
#define I2C_MASTER_TIMEOUT_MS       1000

/* ---- DHT20 specifics ---- */
#define DHT20_ADDR 0x38
#define DHT20_CMD_TRIGGER 0xAC
#define DHT20_CMD_ARG1 0x33
#define DHT20_CMD_ARG2 0x00
#define DHT20_MEASUREMENT_DELAY_MS 100

static const char *TAG = "DHT20";

/* ---- Helper functions ---- */
static esp_err_t dht20_register_read(i2c_master_dev_handle_t dev_handle, uint8_t *data, size_t len)
{
    return i2c_master_receive(dev_handle, data, len, I2C_MASTER_TIMEOUT_MS / portTICK_PERIOD_MS);
}

static esp_err_t dht20_register_write(i2c_master_dev_handle_t dev_handle, const uint8_t *data, size_t len)
{
    return i2c_master_transmit(dev_handle, data, len, I2C_MASTER_TIMEOUT_MS / portTICK_PERIOD_MS);
}

/* ---- I2C bus/device initialization ---- */
static void i2c_master_init(i2c_master_bus_handle_t *bus_handle, i2c_master_dev_handle_t *dev_handle)
{
    i2c_master_bus_config_t bus_config = {
        .i2c_port = I2C_MASTER_NUM,
        .sda_io_num = I2C_MASTER_SDA_IO,
        .scl_io_num = I2C_MASTER_SCL_IO,
        .clk_source = I2C_CLK_SRC_DEFAULT,
        .glitch_ignore_cnt = 7,
        .flags.enable_internal_pullup = true,
    };
    ESP_ERROR_CHECK(i2c_new_master_bus(&bus_config, bus_handle));

    i2c_device_config_t dev_config = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = DHT20_ADDR,
        .scl_speed_hz = I2C_MASTER_FREQ_HZ,
    };
    ESP_ERROR_CHECK(i2c_master_bus_add_device(*bus_handle, &dev_config, dev_handle));
}

/* ---- Data conversion helpers ---- */
static void dht20_calculate(float *temperature, float *humidity, uint8_t *data)
{
    // data[0] = status, data[1..6] = measurement bytes
    uint32_t raw_humidity = ((uint32_t)data[1] << 12) | ((uint32_t)data[2] << 4) | (data[3] >> 4);
    uint32_t raw_temperature = ((uint32_t)(data[3] & 0x0F) << 16) | ((uint32_t)data[4] << 8) | data[5];

    *humidity = (raw_humidity * 100.0) / 1048576.0;     // <-- from datasheet
    *temperature = ((raw_temperature * 200.0) / 1048576.0) - 50.0; // <-- from datasheet
}

/* ---- Main application ---- */
void app_main(void)
{
    i2c_master_bus_handle_t bus_handle;
    i2c_master_dev_handle_t dev_handle;

    i2c_master_init(&bus_handle, &dev_handle);
    ESP_LOGI(TAG, "I2C initialized successfully");

    uint8_t cmd[3] = {DHT20_CMD_TRIGGER, DHT20_CMD_ARG1, DHT20_CMD_ARG2};
    uint8_t data[7];

    while (1) {
        // Send trigger command
        ESP_ERROR_CHECK(dht20_register_write(dev_handle, cmd, sizeof(cmd))); // <-- changed
        vTaskDelay(pdMS_TO_TICKS(DHT20_MEASUREMENT_DELAY_MS));

        // Read 7 bytes of data
        ESP_ERROR_CHECK(dht20_register_read(dev_handle, data, sizeof(data))); // <-- changed
        
        // Check if sensor is busy
        if (data[0] & 0x80) {
            ESP_LOGW(TAG, "Sensor busy, skipping this reading...");
            vTaskDelay(pdMS_TO_TICKS(100));
            continue;
        }

        // Convert and display results
        float temperature, humidity;
        dht20_calculate(&temperature, &humidity, data);
        ESP_LOGI(TAG, "Temperatura: %.2f °C, Humidade: %.2f %%", temperature, humidity);

        vTaskDelay(pdMS_TO_TICKS(2000)); // every 2s
    }

    // Normally we never reach this, but here for completeness:
    ESP_ERROR_CHECK(i2c_master_bus_rm_device(dev_handle));
    ESP_ERROR_CHECK(i2c_del_master_bus(bus_handle));
    ESP_LOGI(TAG, "I2C de-initialized successfully");
}