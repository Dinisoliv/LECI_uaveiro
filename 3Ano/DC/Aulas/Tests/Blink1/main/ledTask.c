#include "ledTask.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "led_strip.h"
#include "esp_log.h"
#include "sdkconfig.h"

#define LED_GPIO    8 
#define MAX_LED     1

static const char *TAG = "LED_TASK";

static TaskHandle_t ledTaskHandle = NULL;
static led_strip_handle_t led_strip;


/* --- LED STRIP INIT --- */
static void led_strip_init(void)
{
    led_strip_config_t strip_config = {
        .strip_gpio_num = LED_GPIO,
        .max_leds = MAX_LED,
    };

    led_strip_rmt_config_t rmt_config = {
        .resolution_hz = 10 * 1000 * 1000, // 10 MHz
    };

    ESP_ERROR_CHECK(led_strip_new_rmt_device(&strip_config, &rmt_config, &led_strip));
    led_strip_clear(led_strip);
}

static void set_rgb(uint8_t r, uint8_t g, uint8_t b)
{
    led_strip_set_pixel(led_strip, 0, r, g, b);
    led_strip_refresh(led_strip);
}

/* ---------------- LED TASK ---------------- */
static void led_task(void *arg)
{
    uint32_t state = LED_STATE_NORMAL;
    led_strip_init();

    while (1) {

        xTaskNotifyWait(0, 0xFFFFFFFF, &state, pdMS_TO_TICKS(20));

        switch (state) {

        case LED_STATE_NORMAL:
            set_rgb(0, 40, 0);   // Green
            break;

        case LED_STATE_MQTT_TX:
            set_rgb(40, 40, 0);  // Yellow
            break;

        case LED_STATE_ERROR:
            set_rgb(40, 0, 0);   // Red
            break;

        default:
            set_rgb(0, 0, 0);
            break;
        }

        vTaskDelay(pdMS_TO_TICKS(100));
    }
}

/* ----------- Public API ------------ */
void led_init(void)
{
    xTaskCreate(led_task, "ledTask", 2048, NULL, 5, &ledTaskHandle);
}

void led_set_state(led_state_t state)
{
    if (ledTaskHandle)
        xTaskNotify(ledTaskHandle, state, eSetValueWithOverwrite);
}
