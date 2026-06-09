#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

static TaskHandle_t receiverHandler = NULL;

/*
void sender(void * params)
{
    while (true)
    {
        // enviar 4 notificações rápidas
        for (int i = 0; i < 4; ++i) {
            xTaskNotifyGive(receiverHandler); // incrementa o count de notifs
        }
        vTaskDelay(5000 / portTICK_PERIOD_MS); // repetir a cada 5s
    }
}

void receiver(void * params)
{
    while (true)
    {
        // bloqueia até receber pelo menos uma notificação;
        // ulTaskNotifyTake retorna o nº de notificações pendentes
        // e (com pdTRUE) limpa o contador.
        uint32_t count = ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        printf("received notification %u times\n", (unsigned)count);
    }
}
*/

void sender(void * params)
{
    const uint32_t values[] = { 1, 2, 4, 8 };
    size_t idx = 0;

    while (true)
    {
        // envia um valor diferente por ciclo
        xTaskNotify(receiverHandler, values[idx], eSetValueWithOverwrite);
        idx = (idx + 1) % (sizeof(values)/sizeof(values[0]));
        vTaskDelay(5000 / portTICK_PERIOD_MS); // 5s entre envios
    }
}

void receiver(void * params)
{
    uint32_t receivedValue;
    while (true)
    {
        // Bloqueia até receber uma notificação; a função preenche receivedValue
        if (xTaskNotifyWait(0x00,      // bits a limpar na entrada (nenhum)
                            0xFFFFFFFF, // limpar todos os bits no retorno
                            &receivedValue, // recebe o valor passado por xTaskNotify
                            portMAX_DELAY) == pdTRUE)
        {
            printf("received notification %u\n", (unsigned)receivedValue);
        }
    }
}

void app_main(void)
{
    xTaskCreate(receiver, "Receiver", 2048, NULL, 2, &receiverHandler);
    xTaskCreate(sender, "Sender", 2048, NULL, 2, NULL);
}
