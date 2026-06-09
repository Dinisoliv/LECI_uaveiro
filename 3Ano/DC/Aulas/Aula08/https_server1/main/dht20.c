#include "dht20.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "sdkconfig.h"

/* ---- I2C configuration ---- */
#define I2C_MASTER_SCL_IO           7
#define I2C_MASTER_SDA_IO           6
#define I2C_MASTER_NUM              I2C_NUM_0
#define I2C_MASTER_FREQ_HZ          100000
#define I2C_MASTER_TIMEOUT_MS       1000

/* ---- DHT20 specifics ---- */
#define DHT20_ADDR          0x38
#define DHT20_CMD_TRIGGER   0xAC
#define DHT20_CMD_ARG1      0x33
#define DHT20_CMD_ARG2      0x00
#define DHT20_DELAY_MS      100

static const char *TAG = "DHT20";

/* Handles internos */
static i2c_master_bus_handle_t s_bus = NULL;
static i2c_master_dev_handle_t s_dev = NULL;

/* ----------------------------------------
   Funções internas auxiliares
   ---------------------------------------- */

static esp_err_t dht20_read_raw(uint8_t *data, size_t len)
{
    return i2c_master_receive(s_dev, data, len,
           I2C_MASTER_TIMEOUT_MS / portTICK_PERIOD_MS);
}

static esp_err_t dht20_write_cmd(uint8_t *data, size_t len)
{
    return i2c_master_transmit(s_dev, data, len,
           I2C_MASTER_TIMEOUT_MS / portTICK_PERIOD_MS);
}

/* ----------------------------------------
   Conversão dos bytes → temp/humd
   ---------------------------------------- */
static void dht20_convert(float *temperature, float *humidity, uint8_t *data)
{
    uint32_t raw_humidity =
        ((uint32_t)data[1] << 12) |
        ((uint32_t)data[2] << 4)  |
        (data[3] >> 4);

    uint32_t raw_temperature =
        ((uint32_t)(data[3] & 0x0F) << 16) |
        ((uint32_t)data[4] << 8) |
        data[5];

    *humidity = (raw_humidity * 100.0f) / 1048576.0f;
    *temperature = ((raw_temperature * 200.0f) / 1048576.0f) - 50.0f;
}

/* ----------------------------------------
           Inicialização completa
   ---------------------------------------- */
esp_err_t dht20_init(i2c_master_bus_handle_t *bus,
                     i2c_master_dev_handle_t *dev)
{
    /* Criar bus I2C */
    i2c_master_bus_config_t bus_conf = {
        .i2c_port = I2C_MASTER_NUM,
        .sda_io_num = I2C_MASTER_SDA_IO,
        .scl_io_num = I2C_MASTER_SCL_IO,
        .glitch_ignore_cnt = 7,
        .clk_source = I2C_CLK_SRC_DEFAULT,
        .flags.enable_internal_pullup = true
    };

    esp_err_t ret;
        
    ret = i2c_new_master_bus(&bus_conf, &s_bus);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Erro ao criar bus I2C: %s", esp_err_to_name(ret));
        return ret;
    }   

    /* Adicionar device */
    i2c_device_config_t dev_conf = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = DHT20_ADDR,
        .scl_speed_hz = I2C_MASTER_FREQ_HZ
    };

    ret = i2c_master_bus_add_device(s_bus, &dev_conf, &s_dev);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Erro device: %s", esp_err_to_name(ret));
        return ret;
    }

    /* Exporta handles se o utilizador quiser guardar */
    if (bus) *bus = s_bus;
    if (dev) *dev = s_dev;

    ESP_LOGI(TAG, "DHT20 inicializado");
    return ESP_OK;
}

/* ----------------------------------------
            Leitura pública
   ---------------------------------------- */
esp_err_t read_dht20(float *temperature, float *humidity)
{
    if (!s_dev) {
        ESP_LOGE(TAG, "Erro: dht20_init() não foi chamado!");
        return ESP_FAIL;
    }

    uint8_t cmd[3] = { DHT20_CMD_TRIGGER, DHT20_CMD_ARG1, DHT20_CMD_ARG2 };
    uint8_t data[7];

    esp_err_t ret;

    /* Disparar medição */
    ret = dht20_write_cmd(cmd, sizeof(cmd));
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Write failed: %s", esp_err_to_name(ret));
        return ret;
    }

    vTaskDelay(pdMS_TO_TICKS(DHT20_DELAY_MS));

    /* Ler dados */
    ret = dht20_read_raw(data, sizeof(data));
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Read failed: %s", esp_err_to_name(ret));
        return ret;
    }

    /* Sensor ocupado */
    if (data[0] & 0x80) {
        ESP_LOGW(TAG, "Sensor ocupado");
        return ESP_ERR_INVALID_STATE;
    }

    /* Converter */
    dht20_convert(temperature, humidity, data);

    return ESP_OK;
}
