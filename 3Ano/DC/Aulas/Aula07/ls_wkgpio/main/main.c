#include <stdio.h>
#include <inttypes.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "esp_sleep.h"
#include "esp_timer.h"
#include "esp_rom_uart.h"

#if CONFIG_ESP_CONSOLE_USB_SERIAL_JTAG
#include "driver/usb_serial_jtag.h"
#endif
#if CONFIG_ESP_CONSOLE_USB_CDC
#include "tinyusb.h"
#include "tusb_cdc_acm.h"
#endif

#define INPUT_PIN GPIO_NUM_0  // Button pin, active low

static void console_flush(void)
{
    fflush(stdout);
#if CONFIG_ESP_CONSOLE_UART
    esp_rom_output_tx_wait_idle(CONFIG_ESP_CONSOLE_UART_NUM);
#elif CONFIG_ESP_CONSOLE_USB_SERIAL_JTAG
    esp_usb_serial_jtag_flush();
#elif CONFIG_ESP_CONSOLE_USB_CDC
    tinyusb_cdcacm_write_flush();
#endif
}

void app_main(void)
{
    // Configure button as input with pull-up (active low)
    gpio_config_t cfg = {
        .pin_bit_mask = 1ULL << INPUT_PIN,
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_DISABLE
    };
    gpio_config(&cfg);

    // Enable GPIO wakeup on low level
    gpio_wakeup_enable(INPUT_PIN, GPIO_INTR_LOW_LEVEL);
    esp_sleep_enable_gpio_wakeup();

    while (true) {
        
        if (gpio_get_level(INPUT_PIN) == 0) {
            printf("please release button\n");
            console_flush();
            do {
                vTaskDelay(pdMS_TO_TICKS(10));
            } while (gpio_get_level(INPUT_PIN) == 0);
        }

        printf("going for a nap\n");
        console_flush();

        int64_t before = esp_timer_get_time();
        esp_light_sleep_start();
        int64_t after = esp_timer_get_time();

        esp_sleep_wakeup_cause_t reason = esp_sleep_get_wakeup_cause();
        const char *why = (reason == ESP_SLEEP_WAKEUP_GPIO) ? "button" : "other";

        printf("woke up after %" PRId64 " ms, reason: %s\n",
               (after - before) / 1000, why);
        console_flush();

        vTaskDelay(pdMS_TO_TICKS(20));  // debounce delay
    }
}
