#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#define INPUT_GPIO GPIO_NUM_9 // choose an available GPIO on your board

void app_main(void)
{
    // Configure the GPIO as input with pull-up enabled
    gpio_config_t io_conf = {
        .pin_bit_mask = 1ULL << INPUT_GPIO, // bit mask for selected GPIO
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE, // enable internal pull-up
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_DISABLE
    };
    
    gpio_config(&io_conf);
    
    while (1) {
        int level = gpio_get_level(INPUT_GPIO); // read the pin state (0 or 1)
        
        // INCLUA AQUI O CODIGO PARA IMPRIMIR O ESTADO DO BOTAO
        
        printf("GPIO%d read %d\n", INPUT_GPIO, level);

        vTaskDelay(pdMS_TO_TICKS(1000)); // check every 1s
    }
}
