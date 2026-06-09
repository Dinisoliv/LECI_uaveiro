#ifndef SDCARD_H
#define SDCARD_H

#include "esp_err.h"

#define PIN_NUM_MISO  20
#define PIN_NUM_MOSI  19
#define PIN_NUM_CLK   21
#define PIN_NUM_CS    18

#define SD_MOUNT_POINT "/sdcard"

esp_err_t mount_sdcard(void);

#endif //SDCARD_H