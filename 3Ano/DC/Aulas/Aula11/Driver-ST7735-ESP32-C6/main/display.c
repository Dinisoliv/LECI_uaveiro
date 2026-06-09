#include "display.h"
#include "freertos/FreeRTOS.h"
#include "freertos/semphr.h"
#include <stdio.h>
#include <string.h>

#define LOG_BUFFER_SIZE 5

#define MAX_GRAPH_POINTS 80

static log_entry_t log_buffer[LOG_BUFFER_SIZE];
static int log_count = 0;

static SemaphoreHandle_t spi_mutex = NULL;

/* -------------------- INTERNAL HELPERS -------------------- */

static const char* get_state_string(float temp) {
    if (temp < 22) return "COLD";
    else if (temp > 30) return "HOT";
    else return "NORMAL";
}

static uint16_t get_state_color(float temp) {
    if (temp < 22) return ST7735_CYAN;
    else if (temp > 30) return ST7735_RED;
    else return ST7735_GREEN;
}

static inline void lock_spi()   { xSemaphoreTake(spi_mutex, portMAX_DELAY); }
static inline void unlock_spi() { xSemaphoreGive(spi_mutex); }

/* -------------------- PUBLIC FUNCTIONS -------------------- */

void display_init(void)
{
    spi_mutex = xSemaphoreCreateMutex();

    st7735_config_t cfg = {
        .mosi_io_num = 19,
        .sclk_io_num = 21,
        .cs_io_num   = 22,
        .dc_io_num   = 2,
        .rst_io_num  = 3,
        .bl_io_num   = 15,
        .host_id     = SPI2_HOST
    };

    st7735_init(&cfg);
    st7735_set_rotation(3);

    lock_spi();
    st7735_fill_screen(ST7735_BLACK);
    unlock_spi();
}

/* Draw static main screen */
void display_draw_main_static(screen_t current_screen)
{
    lock_spi();

    if (current_screen == SCREEN_MAIN)
    {
        char buffer[32];
        char* id = "DEV-001";
    
        st7735_fill_screen(ST7735_BLACK);
    
        st7735_fill_rect(0, 0, st7735_get_width(), 18, ST7735_BLUE);
        sprintf(buffer, "ID: %s", id);
        st7735_draw_string(10, 4, buffer, ST7735_WHITE, ST7735_BLUE, 1);
    
        int mid = st7735_get_width() / 2;
        for (int y = 19; y < st7735_get_height(); y++)
            st7735_draw_pixel(mid, y, ST7735_WHITE);
    
        st7735_draw_string(10, 25, "TEMP", ST7735_WHITE, ST7735_BLACK, 1);
        st7735_draw_string(10, 45, "HUMD", ST7735_WHITE, ST7735_BLACK, 1);
        st7735_draw_string(10, 65, "STAT", ST7735_WHITE, ST7735_BLACK, 1);
    }
    else if (current_screen == SCREEN_LOGS)
    {
        st7735_fill_screen(ST7735_BLACK);
    
        st7735_fill_rect(0, 0, st7735_get_width(), 18, ST7735_BLUE);
        st7735_draw_string(10, 4, "LAST 5 SYSTEM LOGS", ST7735_WHITE, ST7735_BLUE, 1);    }
    else
    {
        st7735_fill_screen(ST7735_BLACK);
    
        st7735_fill_rect(0, 0, st7735_get_width(), 20, ST7735_BLUE);
        st7735_draw_string(10, 4, "TEMP[0,40] HUMD[0,100]", ST7735_WHITE, ST7735_BLUE, 1);
    }
    

    unlock_spi();
}

void display_update_values(float temp, float hum)
{
    char buf[32];

    lock_spi();

    // TEMP
    st7735_fill_rect(90, 25, 80, 15, ST7735_BLACK);
    sprintf(buf, "%.1f C", temp);
    st7735_draw_string(90, 25, buf, ST7735_WHITE, ST7735_BLACK, 1);

    // HUMD
    st7735_fill_rect(90, 45, 60, 15, ST7735_BLACK);
    sprintf(buf, "%.0f %%", hum);
    st7735_draw_string(90, 45, buf, ST7735_WHITE, ST7735_BLACK, 1);

    // STATE
    const char *state = get_state_string(temp);
    uint16_t col = get_state_color(temp);

    st7735_fill_rect(90, 65, 80, 15, ST7735_BLACK);
    st7735_draw_string(90, 65, state, col, ST7735_BLACK, 1);

    unlock_spi();
}

/* Add log entry (circular buffer of last 5) */
void display_add_log(log_entry_t *log)
{
    if (log_count < LOG_BUFFER_SIZE)
        log_buffer[log_count++] = *log;
    else {
        for (int i=0; i<LOG_BUFFER_SIZE-1; i++)
            log_buffer[i] = log_buffer[i+1];
        log_buffer[LOG_BUFFER_SIZE-1] = *log;
    }
}

/* Draw logs screen */
void display_draw_logs(void)
{
    lock_spi();
    st7735_fill_rect(0, 20, st7735_get_width(), st7735_get_height() - 18, ST7735_BLACK);

    for (int i = 0; i < log_count; i++) {
        uint16_t color =
            (log_buffer[i].type == LOG_ERROR) ? ST7735_RED :
            (log_buffer[i].type == LOG_WARN)  ? ST7735_YELLOW :
                                                ST7735_WHITE;

        st7735_draw_string(5, 20 + i * 12,
                           log_buffer[i].message,
                           color, ST7735_BLACK, 1);
    }

    unlock_spi();
}

void display_graph_temp_humd(float temp_values[], int graph_count,
                             float humd_values[], int humd_count,
                             int graph_index)
{
    lock_spi();

    st7735_fill_rect(0, 20, st7735_get_width(), st7735_get_height() - 20, ST7735_BLACK);

    int width = st7735_get_width();
    int height = st7735_get_height();
    int graph_height = height - 20;

    int count = graph_count; // number of stored samples

    for (int i = 0; i < count; i++)
    {
        // Convert logical index (i) -> circular position
        int circ = (graph_index - count + i + MAX_GRAPH_POINTS) % MAX_GRAPH_POINTS;

        int x = i * 2;
        int y_temp = height - 1 - (temp_values[circ] * graph_height / 40);
        int y_hum  = height - 1 - (humd_values[circ] * graph_height / 100);

        st7735_draw_pixel(x, y_temp, ST7735_RED);
        st7735_draw_pixel(x, y_hum,  ST7735_BLUE);
    }

    unlock_spi();
}
