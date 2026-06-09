#include "sensorTask.h"

#include <stdio.h>
#include <stdlib.h>
#include "esp_log.h"


static const char *TAG = "SensorTask";

// ------------------------------
// Global queue variables
// ------------------------------
QueueHandle_t sensorQueue = NULL;
QueueHandle_t logQueue = NULL;   // agora usa logQueue definido no .h

// ------------------------------
// SENSOR TASK
// ------------------------------
static void sensor_task(void *pvParameters)
{
    uint32_t sampling_period_ms = *(uint32_t *)pvParameters;
    float temp, hum;

    while (1) {
        esp_err_t err = read_dht20(&temp, &hum);

        if (err != ESP_OK) {
            ESP_LOGE(TAG, "Falha na leitura do DHT20! Tentar outra vez...");

            // Enviar uma mensagem de log estruturada
            if (logQueue != NULL) {
                log_msg_t log_msg;
                log_msg.timestamp_ms = xTaskGetTickCount() * portTICK_PERIOD_MS;
                snprintf(log_msg.message, LOG_MSG_MAX_LEN, "SENSOR: error reading DHT20");

                if (xQueueSend(logQueue, &log_msg, 0) != pdTRUE) {
                    ESP_LOGW(TAG, "Log queue full — message discarded");
                }
            }

            vTaskDelay(pdMS_TO_TICKS(500));
            continue;
        }

        // Normal sensor data
        sensor_data_t data = {
            .temperature = temp,
            .humidity = hum,
            .tick = xTaskGetTickCount() * portTICK_PERIOD_MS
        };

        if (xQueueSend(sensorQueue, &data, 0) != pdTRUE) {
            ESP_LOGW(TAG, "Sensor queue full — data discarded");
        }

        ESP_LOGI(TAG, "Temp=%.2f  Hum=%.2f  Timestamp=%lu ms",
                 data.temperature, data.humidity, (unsigned long)data.tick);

        vTaskDelay(pdMS_TO_TICKS(sampling_period_ms));
    }
}

// ------------------------------
// INITIALIZATION FUNCTION
// ------------------------------
void sensor_task_init(uint32_t sampling_period_ms, QueueHandle_t sharedLogQueue)
{
    // Initialize DHT20
    dht20_init(NULL, NULL);

    // Use shared log queue
    logQueue = sharedLogQueue;

    // Create sensor queue
    sensorQueue = xQueueCreate(SENSOR_QUEUE_LEN, sizeof(sensor_data_t));
    if (sensorQueue == NULL) {
        ESP_LOGE(TAG, "Failed to create sensorQueue!");
        return;
    }

    // Pass period via malloc to task
    uint32_t *period_ptr = malloc(sizeof(uint32_t));
    if (!period_ptr) {
        ESP_LOGE(TAG, "Failed to allocate memory for task parameter");
        return;
    }
    *period_ptr = sampling_period_ms;

    // Create FreeRTOS task
    xTaskCreate(
        sensor_task,
        "sensor_task",
        4096,
        period_ptr,
        5,
        NULL
    );
}
