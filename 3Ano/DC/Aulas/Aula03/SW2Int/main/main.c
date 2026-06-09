#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "driver/gpio.h"
#define INPUT_GPIO GPIO_NUM_9 // example input pin

static QueueHandle_t gpio_evt_queue = NULL;

// ISR handler
static void IRAM_ATTR gpio_isr_handler(void *arg)
{
    uint32_t gpio_num = (uint32_t) arg;
    // Send GPIO number to the queue (from ISR context)
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
}

// Task that handles GPIO events
static void gpio_task(void *arg)
{
    uint32_t io_num;
    for(;;) {
    if (xQueueReceive(gpio_evt_queue, &io_num, portMAX_DELAY)) {
        // INCLUA AQUI O CODIGO PARA IMPRIMIR O NUMERO DO GPIO ORIGEM DA INTERRUPCAO
        printf("GPIO Interrupt on GPIO %u\n", (unsigned)io_num);
        }
    }
}
void app_main(void)
{
    // Configure the GPIO as input with pull-up, interrupt on falling edge
    gpio_config_t io_conf = {
        .pin_bit_mask = 1ULL << INPUT_GPIO,
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_NEGEDGE
    };
    gpio_config(&io_conf);

    // Create a queue to handle GPIO events
    gpio_evt_queue = xQueueCreate(10, sizeof(uint32_t));

    // Start the task that will process GPIO events
    xTaskCreate(gpio_task, "gpio_task", 2048, NULL, 10, NULL);

    // Install GPIO ISR service
    gpio_install_isr_service(0);

    // Hook ISR handler for specific GPIO
    gpio_isr_handler_add(INPUT_GPIO, gpio_isr_handler, (void*) INPUT_GPIO);

    printf("Waiting for GPIO %d falling edge interrupts...", INPUT_GPIO);
}
