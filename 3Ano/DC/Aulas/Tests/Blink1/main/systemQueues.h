#ifndef SYSTEM_QUEUES_H
#define SYSTEM_QUEUES_H

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"

#define LOG_QUEUE_LEN 10
#define SENSOR_QUEUE_LEN 10

// ------------------------------
// Sensor data struct (for sensorQueue)
// ------------------------------
typedef struct {
    float temperature;
    float humidity;
    TickType_t tick; // timestamp in ms
} sensor_data_t;

// ------------------------------
// Error message struct (for errorQueue)
// ------------------------------
#define LOG_MSG_MAX_LEN 32
typedef struct {
    uint32_t timestamp_ms;
    char message[LOG_MSG_MAX_LEN];
} log_msg_t;

// ------------------------------
// Queues (extern, global)
// ------------------------------
extern QueueHandle_t sensorQueue;
extern QueueHandle_t logQueue;


#endif // SYSTEM_QUEUES_H
