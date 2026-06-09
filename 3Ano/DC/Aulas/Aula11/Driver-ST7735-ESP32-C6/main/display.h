#ifndef DISPLAY_H
#define DISPLAY_H

#include <stdint.h>
#include "st7735.h"
#include "sysqueues.h"

typedef enum {
    SCREEN_MAIN = 0,
    SCREEN_LOGS = 1,
    SCREEN_GRAPH = 2
} screen_t;

void display_init(void);
void display_draw_main_static(screen_t current_screen);
void display_update_values(float temp, float hum);
void display_add_log(log_entry_t *log);
void display_draw_logs(void);
void display_graph_temp_humd(float temp_values[], int temp_count,
                             float humd_values[], int humd_count, int graph_index);

#endif
