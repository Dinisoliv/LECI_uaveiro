#ifndef SYSQUEUES_H
#define SYSQUEUES_H

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"

/* ---- Shared queue data types ---- */

typedef struct {
    float temperature;
    float humidity;
} sensor_data_t;

typedef enum {
    LOG_INFO = 0,
    LOG_WARN = 1,
    LOG_MQTT_TX = 2,
    LOG_ERROR = 3
} log_type_t;

typedef struct {
    char message[64];
    log_type_t type;
} log_entry_t;

/* ---- Extern declarations (if needed by other modules) ---- */
/* Usually only the module that creates them defines them. */
/* Other modules include this header to get the types.      */

#endif
