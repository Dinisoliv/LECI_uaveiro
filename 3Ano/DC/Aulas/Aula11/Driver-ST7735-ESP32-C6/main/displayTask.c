#include "displayTask.h"
#include "display.h"
#include "sysqueues.h"

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

#include "driver/gpio.h"
#include "driver/ledc.h"

#include "esp_adc/adc_oneshot.h"
#include "esp_adc/adc_cali.h"
#include "esp_adc/adc_cali_scheme.h"

#include "esp_log.h"
#include <math.h>

#define TAG "DISPLAY_TASK"

#define BL_GPIO 15
#define LEDC_MODE LEDC_LOW_SPEED_MODE
#define LEDC_CHANNEL LEDC_CHANNEL_0
#define LEDC_TIMER LEDC_TIMER_0
#define LEDC_FREQ 10000
#define LEDC_RES LEDC_TIMER_10_BIT

// ---- ADC config ----
#define ADC_UNIT ADC_UNIT_1
#define ADC_CHANNEL ADC_CHANNEL_0 
#define ADC_ATTEN ADC_ATTEN_DB_12

#define INPUT_GPIO  GPIO_NUM_9
#define MAX_GRAPH_POINTS 80

/* --------- Queues passed from main --------- */
static QueueHandle_t sensor_queue = NULL;
static QueueHandle_t log_queue = NULL;
static QueueHandle_t gpio_evt_queue = NULL;

/* --------- Graph buffer --------- */
static float temp_buffer[MAX_GRAPH_POINTS];
static float humd_buffer[MAX_GRAPH_POINTS];
static int graph_index = 0;
static int graph_count = 0;

/* --------- Screen state --------- */
volatile screen_t current_screen = SCREEN_MAIN;

/* -------- ADC handles -------- */
static adc_oneshot_unit_handle_t adc_handle = NULL;
static adc_cali_handle_t cali_handle = NULL;

/* -------- ISR ---------- */
static void IRAM_ATTR gpio_isr_handler(void *arg)
{
    static uint32_t last_isr_tick = 0;
    uint32_t now = xTaskGetTickCountFromISR();
    uint32_t num = (uint32_t)arg;

    if (now - last_isr_tick > pdMS_TO_TICKS(100)) {  // 100 ms debounce
        last_isr_tick = now;
        xQueueSendFromISR(gpio_evt_queue, &num, NULL);
    }
}

/* -------- BUTTON TASK ---------- */
static void button_task(void *arg)
{
    uint32_t io;

    while (1) {
        if (xQueueReceive(gpio_evt_queue, &io, portMAX_DELAY)) {

            if (current_screen == SCREEN_MAIN)
                current_screen = SCREEN_LOGS;
            else if (current_screen == SCREEN_LOGS)
                current_screen = SCREEN_GRAPH;
            else
                current_screen = SCREEN_MAIN;

            display_draw_main_static(current_screen);
        }
    }
}

/* -------- UI TASK ---------- */
void ui_task(void *pv)
{
    sensor_data_t sd;
    log_entry_t lg;

    display_draw_main_static(current_screen);

    while (1) {

        /* ----------- NEW ADC READ (CALIBRATED) ----------- */
        int raw = 0, voltage_mv = 0;

        esp_err_t r1 = adc_oneshot_read(adc_handle, ADC_CHANNEL, &raw);
        esp_err_t r2 = adc_cali_raw_to_voltage(cali_handle, raw, &voltage_mv);

        if (r1 == ESP_OK && r2 == ESP_OK) {
            float voltage = voltage_mv / 1000.0f;
            //ESP_LOGI(TAG, "ADC raw=%d, V=%.3f", raw, voltage);

            // Apply gamma correction for perceived brightness
            float gamma = 2.0f; // gamma correction factor
            float normalized = voltage / 3.3f; // 0.0 - 1.0

            // Apply gamma correction
            float corrected = powf(normalized, gamma);

            // Map to PWM duty
            int duty = (int)(corrected * 1023.0f);
            if (duty < 1) duty = 1;    // avoid 0 (flicker)
            if (duty > 1023) duty = 1023;

            ledc_set_duty(LEDC_MODE, LEDC_CHANNEL, duty);
            ledc_update_duty(LEDC_MODE, LEDC_CHANNEL);
            
            /* Original linear mapping
            // map the voltage to PWM duty cycle (0-1023)
            int duty = (voltage / 3.3f) * 1023.0f;
            if (duty < 0) duty = 1;
            if (duty > 1023) duty = 1023;

            ledc_set_duty(LEDC_MODE, LEDC_CHANNEL, duty);
            ledc_update_duty(LEDC_MODE, LEDC_CHANNEL);
            */
        }

        /* ----------- SENSOR QUEUE ----------- */
        while (xQueueReceive(sensor_queue, &sd, 0)) {

            temp_buffer[graph_index] = sd.temperature;
            humd_buffer[graph_index] = sd.humidity;

            graph_index = (graph_index + 1) % MAX_GRAPH_POINTS;
            if (graph_count < MAX_GRAPH_POINTS)
                graph_count++;

            if (current_screen == SCREEN_MAIN)
                display_update_values(sd.temperature, sd.humidity);

            if (current_screen == SCREEN_GRAPH)
                display_graph_temp_humd(
                    temp_buffer,
                    graph_count,
                    humd_buffer,
                    graph_count,
                    graph_index);
        }

        /* ----------- LOG QUEUE ----------- */
        while (xQueueReceive(log_queue, &lg, 0)) {

            display_add_log(&lg);

            if (current_screen == SCREEN_LOGS)
                display_draw_logs();
        }

        vTaskDelay(pdMS_TO_TICKS(50));
    }
}


/* -------- PUBLIC INIT FUNCTION ---------- */
void displayTask_init(QueueHandle_t sensor_q, QueueHandle_t log_q)
{
    display_init();

    sensor_queue = sensor_q;
    log_queue    = log_q;

    gpio_evt_queue = xQueueCreate(10, sizeof(uint32_t));

    /* Setup button */
    gpio_config_t cfg = {
        .pin_bit_mask = 1ULL << INPUT_GPIO,
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = true,
        .intr_type = GPIO_INTR_NEGEDGE
    };
    gpio_config(&cfg);

    gpio_install_isr_service(0);
    gpio_isr_handler_add(INPUT_GPIO, gpio_isr_handler, (void*)INPUT_GPIO);

    /* -------- PWM BACKLIGHT INIT -------- */
    ledc_timer_config_t ledc_timer = {
        .speed_mode = LEDC_MODE,
        .timer_num = LEDC_TIMER,
        .freq_hz = LEDC_FREQ,
        .duty_resolution = LEDC_RES,
        .clk_cfg = LEDC_AUTO_CLK
    };
    ledc_timer_config(&ledc_timer);

    ledc_channel_config_t ledc_channel_cfg = {
        .gpio_num = BL_GPIO,
        .speed_mode = LEDC_MODE,
        .channel = LEDC_CHANNEL,
        .timer_sel = LEDC_TIMER,
        .duty = 0,
        .hpoint = 0
    };
    ledc_channel_config(&ledc_channel_cfg);

    /* -------- NEW ADC INIT -------- */

    // One-shot ADC unit
    adc_oneshot_unit_init_cfg_t init_cfg = {
        .unit_id = ADC_UNIT,
        .ulp_mode = ADC_ULP_MODE_DISABLE,
    };
    adc_oneshot_new_unit(&init_cfg, &adc_handle);

    // Channel config
    adc_oneshot_chan_cfg_t chan_cfg = {
        .atten = ADC_ATTEN,
        .bitwidth = ADC_BITWIDTH_DEFAULT
    };
    adc_oneshot_config_channel(adc_handle, ADC_CHANNEL, &chan_cfg);

    // Calibration
    adc_cali_curve_fitting_config_t cali_cfg = {
        .unit_id = ADC_UNIT,
        .atten = ADC_ATTEN,
        .bitwidth = ADC_BITWIDTH_DEFAULT,
    };
    adc_cali_create_scheme_curve_fitting(&cali_cfg, &cali_handle);

    /* -------- tasks -------- */
    xTaskCreate(button_task, "button", 2048, NULL, 10, NULL);
    xTaskCreate(ui_task,     "ui",     4096, NULL,  5, NULL);
}
