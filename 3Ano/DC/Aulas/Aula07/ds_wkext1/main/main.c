#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "esp_sleep.h"
#include "driver/rtc_io.h"
#include "driver/gpio.h"

#define INPUT_PIN GPIO_NUM_0   // RTC GPIO on C6; button pulls to GND when pressed

RTC_DATA_ATTR int timesWokenUp = 0;

void app_main(void)
{
    // Configure pin as RTC IO with pull-up so idle = HIGH, press = LOW
    rtc_gpio_init(INPUT_PIN);
    rtc_gpio_set_direction(INPUT_PIN, RTC_GPIO_MODE_INPUT_ONLY);
    rtc_gpio_pullup_en(INPUT_PIN);
    rtc_gpio_pulldown_dis(INPUT_PIN);

    // Keep RTC_PERIPH on so the internal pull-up stays active in sleep
    esp_sleep_pd_config(ESP_PD_DOMAIN_RTC_PERIPH, ESP_PD_OPTION_ON);

    // Wake on ANY_LOW of selected RTC GPIOs (ESP32-C6 supports ANY_LOW/ANY_HIGH)
    esp_sleep_enable_ext1_wakeup_io(1ULL << INPUT_PIN, ESP_EXT1_WAKEUP_ANY_LOW);

    printf("Going to deep sleep. Woken up %d\n", timesWokenUp++);

    // Enter deep sleep
    esp_deep_sleep_start();
}
