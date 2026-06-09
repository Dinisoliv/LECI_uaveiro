#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/ledc.h"
#define LED_GPIO GPIO_NUM_10
#define LEDC_CHANNEL LEDC_CHANNEL_0
#define LEDC_TIMER LEDC_TIMER_0
#define LEDC_MODE LEDC_LOW_SPEED_MODE
#define LEDC_DUTY_RES LEDC_TIMER_13_BIT // 13-bit resolution
#define LEDC_FREQUENCY 5000 // 5 kHz PWM

void app_main(void)
{
    // 1. Configure timer
    ledc_timer_config_t ledc_timer = {
        .speed_mode = LEDC_MODE,
        .timer_num = LEDC_TIMER,
        .duty_resolution = LEDC_DUTY_RES,
        .freq_hz = LEDC_FREQUENCY,
        .clk_cfg = LEDC_AUTO_CLK
    };
    ledc_timer_config(&ledc_timer);

    // 2. Configure channel
    ledc_channel_config_t ledc_channel = {
        .gpio_num = LED_GPIO,
        .speed_mode= LEDC_MODE,
        .channel = LEDC_CHANNEL,
        .intr_type = LEDC_INTR_DISABLE,
        .timer_sel = LEDC_TIMER,
        .duty = 0,
        .hpoint = 0
    };
    ledc_channel_config(&ledc_channel);

    uint32_t max_duty = (1 << LEDC_DUTY_RES) - 1;
    
    //uint32_t duty_10 = max_duty / 10;

    //uint32_t duties[] = {max_duty / 10, max_duty / 2, (max_duty * 8) / 10};
    //int num_levels = sizeof(duties) / sizeof(duties[0]);

    int step = max_duty / 100; // 1% step

    while (1) {
        //ledc_set_duty(LEDC_MODE, LEDC_CHANNEL, duty_10);
        //ledc_update_duty(LEDC_MODE, LEDC_CHANNEL);
        //vTaskDelay(pdMS_TO_TICKS(1000));

        /*
        for (int i = 0; i < num_levels; i++) {
            ledc_set_duty(LEDC_MODE, LEDC_CHANNEL, duties[i]);
            ledc_update_duty(LEDC_MODE, LEDC_CHANNEL);
            vTaskDelay(pdMS_TO_TICKS(2000)); // 2s each level
        }
        */

        // Fade in (brighten)
        for (int32_t duty = 0; duty <= max_duty; duty += step) {
            ledc_set_duty(LEDC_MODE, LEDC_CHANNEL, duty);
            ledc_update_duty(LEDC_MODE, LEDC_CHANNEL);
            vTaskDelay(pdMS_TO_TICKS(10));
        }

        // Small pause at full brightness (optional)
        vTaskDelay(pdMS_TO_TICKS(200));

        // Fade out (dim)
        for (int32_t duty = max_duty; duty > 0; duty -= step) {
            ledc_set_duty(LEDC_MODE, LEDC_CHANNEL, duty);
            ledc_update_duty(LEDC_MODE, LEDC_CHANNEL);
            vTaskDelay(pdMS_TO_TICKS(10));
        }

        // Small pause at darkness (optional)
        vTaskDelay(pdMS_TO_TICKS(200));
    }
}