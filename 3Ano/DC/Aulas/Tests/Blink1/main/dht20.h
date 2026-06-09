#ifndef DHT20_H
#define DHT20_H

#include "esp_err.h"
#include "driver/i2c_master.h"

/* Inicializa o DHT20 (bus + device) */
esp_err_t dht20_init(i2c_master_bus_handle_t *bus,
                     i2c_master_dev_handle_t *dev);

/* Faz uma leitura e devolve temperatura + humidade */
esp_err_t read_dht20(float *temperature, float *humidity);

#endif
