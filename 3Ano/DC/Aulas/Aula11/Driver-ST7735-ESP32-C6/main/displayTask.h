#ifndef DISPLAY_TASK_H
#define DISPLAY_TASK_H

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "display.h"

void displayTask_init(QueueHandle_t sensor_q, QueueHandle_t log_q);

#endif
