#ifndef LOGS_H
#define LOGS_H

#include "esp_err.h"
#include "esp_log.h"
#include "freertos/queue.h"
#include "freertos/FreeRTOS.h"
#include "systemQueues.h"

#define SD_MOUNT_POINT "/sdcard"
#define MAX_CHAR_SIZE 100

//if the file doesn't exist, creates the header
void logs_init(QueueHandle_t LogQueue, QueueHandle_t SensorQueue);

// logging functions
esp_err_t write_sensor(const sensor_data_t *data);
esp_err_t write_logs(const log_msg_t *msg);

// Task responsible for consuming the queues and calling the writing functions
void logTask(void *pvParameters);

#endif // LOGS_H
