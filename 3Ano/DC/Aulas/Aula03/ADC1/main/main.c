#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_adc/adc_oneshot.h"

#include "esp_adc/adc_cali.h"
#include "esp_adc/adc_cali_scheme.h"

#include "esp_log.h"

#define ADC_CHANNEL ADC_CHANNEL_0 // GPIO0 (check pin mapping for ESP32-C6)
#define ADC_UNIT ADC_UNIT_1 // Use ADC1
#define ADC_ATTEN ADC_ATTEN_DB_12 // 12 dB, ~1.1 V full-scale

static const char *TAG = "ADC_CALIBRATED";

void app_main(void)
{
    // ADC Oneshot driver handle
    adc_oneshot_unit_handle_t adc1_handle;
    adc_oneshot_unit_init_cfg_t init_config1 = {
        .unit_id = ADC_UNIT,
        .ulp_mode = ADC_ULP_MODE_DISABLE,
    };
    ESP_ERROR_CHECK(adc_oneshot_new_unit(&init_config1, &adc1_handle));
    
    // Configure channel
    adc_oneshot_chan_cfg_t config = {
        .atten = ADC_ATTEN,
        .bitwidth = ADC_BITWIDTH_DEFAULT, // default = 12-bit
    };
    ESP_ERROR_CHECK(adc_oneshot_config_channel(adc1_handle, ADC_CHANNEL, &config));
    
    adc_cali_handle_t cali_handle;
    adc_cali_curve_fitting_config_t cali_cfg = {
        .unit_id = ADC_UNIT_1,
        .atten = ADC_ATTEN,
        .bitwidth = ADC_BITWIDTH_DEFAULT,
    };
    ESP_ERROR_CHECK(adc_cali_create_scheme_curve_fitting(&cali_cfg, &cali_handle));

    while (1) {
        //int adc_raw = 0;
        //adc_oneshot_read(adc1_handle, ADC_CHANNEL, &adc_raw);
        
        // Convert raw value to voltage (approximate, no calibration)
        //float voltage = (adc_raw / 4095.0f) * (1.1f/0.25f);

        int raw = 0, voltage_mv = 0;
        
        ESP_ERROR_CHECK(adc_oneshot_read(adc1_handle, ADC_CHANNEL_0, &raw));
        ESP_ERROR_CHECK(adc_cali_raw_to_voltage(cali_handle, raw, &voltage_mv));

        // Usando logs (ao invés de printf)
        ESP_LOGI(TAG, "ADC Raw: %d, Calibrated Voltage: %.3f V", raw, voltage_mv / 1000.0f);

        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}