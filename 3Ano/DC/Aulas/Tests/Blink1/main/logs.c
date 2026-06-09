#include <stdio.h>

#include "systemQueues.h"

#include "esp_log.h"
#include "esp_vfs_fat.h"
#include "sdmmc_cmd.h"

#include "logs.h"

QueueHandle_t sensorQueue = NULL;
QueueHandle_t logQueue = NULL;     // antes errorQueue
static const char *TAG = "LOGS";

//config
#define SENSOR_FILE     SD_MOUNT_POINT "/sensor.txt"
#define LOG_FILE        SD_MOUNT_POINT "/log.txt"

// ======================================================
//  Inicializes both the documents with the header
// ======================================================
void logs_init(QueueHandle_t LogQueue, QueueHandle_t SensorQueue)
{
    // sensor log
    FILE *f_sensor = fopen(SENSOR_FILE, "r");
    if (f_sensor == NULL) {
        // if the file doesn't exist, creates the header
        f_sensor = fopen(SENSOR_FILE, "w");
        if (f_sensor) {
            fprintf(f_sensor, "tick_ms,temperature,humidity\n");
            fclose(f_sensor);
            ESP_LOGI(TAG, "Criado sensor.txt");
        }
    } else {
        fclose(f_sensor);
    }
    
    // Log/messages file
    FILE *f_log = fopen(LOG_FILE, "r");
    if (f_log == NULL) {
        f_log = fopen(LOG_FILE, "w");
        if (f_log) {
            fprintf(f_log, "[tick_ms] message\n");
            fclose(f_log);
            ESP_LOGI(TAG, "Criado log.txt");
        }
    } else {
        fclose(f_log);
    }

    sensorQueue = SensorQueue;
    logQueue = LogQueue;

    //Creates the logtask
    xTaskCreate(logTask, "logTask", 4096, NULL, 5, NULL);
}

// ======================================================
//  Writing functions for each Queue
// ======================================================

esp_err_t write_sensor(const sensor_data_t *data)
{
    FILE *f_s = fopen(SENSOR_FILE, "a"); // append
    if (f_s == NULL) {
        ESP_LOGE(TAG, "Falha ao abrir o ficheiro %s", SENSOR_FILE);
        return ESP_FAIL;
    }

    fprintf(f_s, "%lu, %.2f, %.2f\n",
            (unsigned long)data->tick, data->temperature, data->humidity);

    fclose(f_s);
    return ESP_OK;
}


esp_err_t write_logs(const log_msg_t *data)
{
    FILE *f = fopen(LOG_FILE, "a");
    if (f == NULL) {
        ESP_LOGE(TAG, "Falha ao abrir o ficheiro %s", LOG_FILE);
        return ESP_FAIL;
    }

    fprintf(f, "%lu: %s\n",
            (unsigned long)data->timestamp_ms, data->message);

    fclose(f);
    return ESP_OK;
}


// ======================================================
//  TASK FREE RTOS 
// ======================================================

void logTask(void *pvParameters)
{
    sensor_data_t sensor_data;
    log_msg_t log_data;     // antes error_msg_t

    const TickType_t wait_time = pdMS_TO_TICKS(500);

    ESP_LOGI(TAG, "Log iniciada!");
    
    int received = 0;

    while (1) {

        // SENSOR QUEUE
        if (xQueueReceive(sensorQueue, &sensor_data, 0) == pdTRUE) {
            ESP_LOGI(TAG, "Recebido sensor log");
            write_sensor(&sensor_data);
            received = 1;
        }

        // LOG QUEUE (antes errorQueue)
        if (xQueueReceive(logQueue, &log_data, 0) == pdTRUE) {
            ESP_LOGI(TAG, "Recebido log message");
            write_logs(&log_data);
            received = 1;
        }

        if (!received) {
            vTaskDelay(wait_time);
        }

        received = 0;
        vTaskDelay(pdMS_TO_TICKS(50)); // small delay
    }
}
