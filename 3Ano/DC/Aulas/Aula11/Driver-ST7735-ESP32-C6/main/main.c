#include <stdio.h>
#include <stdlib.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

#include "displayTask.h"
#include "sysqueues.h"

#define MAX_FAKE_TEMP 40
#define MAX_FAKE_HUM  100

QueueHandle_t sensor_queue;
QueueHandle_t log_queue;

/* ---------- FAKE SENSOR TASK ---------- */
void fake_sensor_task(void *pv)
{
    sensor_data_t d;

    while (1) {
        d.temperature = 18 + rand() % 20;
        d.humidity    = 40 + rand() % 40;

        xQueueSend(sensor_queue, &d, 0);
        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}

/* ---------- FAKE LOG TASK ---------- */
void fake_log_task(void *pv)
{
    log_entry_t log;
    int c = 0;

    while (1) {
        sprintf(log.message, "Log %d", c++);

        if (c % 7 == 0) log.type = LOG_WARN;
        else if (c % 13 == 0) log.type = LOG_ERROR;
        else log.type = LOG_INFO;

        xQueueSend(log_queue, &log, 0);
        vTaskDelay(pdMS_TO_TICKS(1500));
    }
}

/* ---------- MAIN ---------- */
void app_main()
{
    sensor_queue = xQueueCreate(5, sizeof(sensor_data_t));
    log_queue    = xQueueCreate(5, sizeof(log_entry_t));   // now circular 5 logs

    /* Start DisplayTask module */
    displayTask_init(sensor_queue, log_queue);

    /* Start fake-data tasks */
    xTaskCreate(fake_sensor_task, "sensor_gen", 4096, NULL,  4, NULL);
    xTaskCreate(fake_log_task,    "log_gen",    4096, NULL,  3, NULL);
}
