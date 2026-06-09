#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"

SemaphoreHandle_t busMutex; // Mutex global

void writeToBus(char *message)
{
    printf(message);
}

void task1(void *params)    
{
    while (true)
    {
        printf("reading temperature \n");
 
         if (xSemaphoreTake(busMutex, 100 / portTICK_PERIOD_MS) == pdTRUE){
            writeToBus("temperature is 25c\n");
            xSemaphoreGive(busMutex);
         }
         else {
            printf("writing temperature timed out\n");
         }
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}

void task2(void *params)
{
    while (true)
    {
        printf("reading humidity\n");
        if (xSemaphoreTake(busMutex, 100 / portTICK_PERIOD_MS) == pdTRUE)
        {
            writeToBus("humidity is 50 \n");
            xSemaphoreGive(busMutex);
        }
        else {
            printf("writing humidity timed out\n");
        }
        vTaskDelay(2000 / portTICK_PERIOD_MS);
    }
}

void app_main(void)
{
    // Criação do mutex antes das tarefas
    busMutex = xSemaphoreCreateMutex();

    if (busMutex == NULL)
    {
        printf("Failed to create mutex!\n");
        return;
    }
    
    xTaskCreate(&task1, "temperature reading", 2048, NULL, 2, NULL);
    xTaskCreate(&task2, "humidity reading", 2048, NULL, 2, NULL);
}