#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "esp_sleep.h"
#include "esp_log.h"
#include "esp_timer.h"
#include "esp_rom_uart.h"

#if CONFIG_ESP_CONSOLE_USB_SERIAL_JTAG
#include "driver/usb_serial_jtag.h"
#endif
#if CONFIG_ESP_CONSOLE_USB_CDC
#include "tinyusb.h"
#include "tusb_cdc_acm.h"
#endif

static void console_flush(void)
{
    fflush(stdout);                  // flush stdio buffers

#if CONFIG_ESP_CONSOLE_UART
    esp_rom_output_tx_wait_idle(CONFIG_ESP_CONSOLE_UART_NUM);   // ROM UART flush, no driver needed
#elif CONFIG_ESP_CONSOLE_USB_SERIAL_JTAG
    esp_usb_serial_jtag_flush();                              // flush USB-Serial-JTAG
#elif CONFIG_ESP_CONSOLE_USB_CDC
    tinyusb_cdcacm_write_flush();                             // flush USB-CDC (TinyUSB)
#endif
}

void app_main(void)
{
    while(1){
        esp_sleep_enable_timer_wakeup(1000000); // 1 s
        printf("going for a nap\n");
        console_flush();

        int64_t before = esp_timer_get_time();
        esp_light_sleep_start();
        int64_t after = esp_timer_get_time();

        printf("napped for %lld\n", (after - before) / 1000);
        console_flush();
    }
}
