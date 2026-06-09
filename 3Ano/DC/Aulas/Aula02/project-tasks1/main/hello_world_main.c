#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

void task1()
{
    while (true)
    {
        printf("reading temperature \n");
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}

void task2()
{
    while (true)
    {
        printf("reading humidity \n");
        vTaskDelay(2000 / portTICK_PERIOD_MS);
    }
}

void sensorTask(void *pvParameters)
{
    char *taskName = (char *)pvParameters;
    int delay = strcmp(taskName, "task1") == 0 ? 1000 : 2000;

    while (true)
    {
        printf("reading %s from %s\n",
               strcmp(taskName, "task1") == 0 ? "temperature" : "humidity",
               taskName);
        vTaskDelay(delay / portTICK_PERIOD_MS);
    }
}

void taskHigh(void *pvParameters)
{
    while (true)
    {
        printf("High priority running!\n");
        // sem vTaskDelay -> monopoliza o CPU
    }
}

void app_main(void)
{
    //xTaskCreate(task1, "Task1", 2048, NULL, 1, NULL);
    //xTaskCreate(task2, "Task2", 2048, NULL, 1, NULL);
    xTaskCreate(sensorTask, "Task1", 2048, "task1", 1, NULL);
    xTaskCreate(sensorTask, "Task2", 2048, "task2", 1, NULL);
    xTaskCreate(taskHigh, "Task2", 2048, NULL, 1, NULL);
}