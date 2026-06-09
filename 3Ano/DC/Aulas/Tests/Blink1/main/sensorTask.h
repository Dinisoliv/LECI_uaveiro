#ifndef SENSOR_TASK_H
#define SENSOR_TASK_H

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "freertos/task.h"
#include "systemQueues.h"

#include "dht20.h"

// ------------------------------
// Initialize sensor task
// - sampling_period_ms: period of sensor readings
// - sharedErrorQueue: pointer to the shared error queue
// ------------------------------
void sensor_task_init(uint32_t sampling_period_ms, QueueHandle_t sharedLogQueue);

#endif // SENSOR_TASK_H
