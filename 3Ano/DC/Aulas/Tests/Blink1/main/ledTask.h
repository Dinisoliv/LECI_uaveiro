#ifndef LEDTASK_H
#define LEDTASK_H

#include <stdint.h>

typedef enum {
    LED_STATE_NORMAL  = 1, // verde
    LED_STATE_MQTT_TX = 2, // amarelo
    LED_STATE_ERROR   = 3  // vermelho
} led_state_t;

void led_init(void);
void led_set_state(led_state_t state);

#endif // LEDTASK_H
