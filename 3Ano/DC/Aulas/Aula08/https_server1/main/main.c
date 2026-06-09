/* HTTPS + DHT20 + SoftAP Example for ESP32-C6
 *
 * This version satisfies QUESTÃO 10:
 * - ESP32 starts a SoftAP
 * - Clients connect and receive DHCP IP automatically
 * - HTTPS server responds with DHT20 temperature + humidity
 */

#include "dht20.h"
#include <esp_wifi.h>
#include <esp_event.h>
#include <esp_log.h>
#include <esp_system.h>
#include <nvs_flash.h>
#include "esp_netif.h"
#include <esp_https_server.h>
#include "esp_tls.h"
#include <string.h>

static const char *TAG = "https_dht20";

/****************** DHT20 HANDLES ******************/
static i2c_master_bus_handle_t g_bus = NULL;
static i2c_master_dev_handle_t g_dev = NULL;

/****************** SoftAP settings ******************/
#define AP_SSID "ESP32_AP"
#define AP_PASS "12345678"
#define MAX_STA_CONN 4

/****************** SoftAP Initialization ******************/
static void init_softap(void)
{
    esp_netif_create_default_wifi_ap();

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));

    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_AP));   // ONLY AP mode

    wifi_config_t ap_config = {
        .ap = {
            .ssid = AP_SSID,
            .ssid_len = strlen(AP_SSID),
            .password = AP_PASS,
            .channel = 1,
            .max_connection = MAX_STA_CONN,
            .authmode = WIFI_AUTH_WPA_WPA2_PSK
        },
    };

    if (strlen(AP_PASS) == 0)
        ap_config.ap.authmode = WIFI_AUTH_OPEN;

    ESP_ERROR_CHECK(esp_wifi_set_config(WIFI_IF_AP, &ap_config));
    ESP_ERROR_CHECK(esp_wifi_start());

    ESP_LOGI(TAG, "SoftAP active. SSID:%s PASSWORD:%s", AP_SSID, AP_PASS);
    ESP_LOGI(TAG, "Connect to: https://192.168.4.1/");
}

/****************** HTTPS Handler ******************/
static esp_err_t root_get_handler(httpd_req_t *req)
{
    float temperature = 0.0f;
    float humidity = 0.0f;

    if (read_dht20(&temperature, &humidity) != ESP_OK) {
        httpd_resp_send(req, "<h1>Sensor Error</h1>", HTTPD_RESP_USE_STRLEN);
        return ESP_OK;
    }

    char html[512];
    snprintf(html, sizeof(html),
             "<html><body>"
             "<h1>DHT20 Readings</h1>"
             "<p><b>Temperature:</b> %.2f °C</p>"
             "<p><b>Humidity:</b> %.2f %%</p>"
             "</body></html>",
             temperature, humidity);

    httpd_resp_send(req, html, HTTPD_RESP_USE_STRLEN);
    return ESP_OK;
}

static const httpd_uri_t root = {
    .uri = "/",
    .method = HTTP_GET,
    .handler = root_get_handler
};

/****************** Start HTTPS Server ******************/
static httpd_handle_t start_webserver(void)
{
    httpd_handle_t server = NULL;
    httpd_ssl_config_t conf = HTTPD_SSL_CONFIG_DEFAULT();

    extern const unsigned char servercert_start[] asm("_binary_servercert_pem_start");
    extern const unsigned char servercert_end[]   asm("_binary_servercert_pem_end");
    conf.servercert = servercert_start;
    conf.servercert_len = servercert_end - servercert_start;

    extern const unsigned char prvtkey_pem_start[] asm("_binary_prvtkey_pem_start");
    extern const unsigned char prvtkey_pem_end[]   asm("_binary_prvtkey_pem_end");
    conf.prvtkey_pem = prvtkey_pem_start;
    conf.prvtkey_len = prvtkey_pem_end - prvtkey_pem_start;

    if (httpd_ssl_start(&server, &conf) != ESP_OK) {
        ESP_LOGE(TAG, "Failed to start HTTPS server");
        return NULL;
    }

    httpd_register_uri_handler(server, &root);
    ESP_LOGI(TAG, "HTTPS server started at https://192.168.4.1/");
    return server;
}

/****************** MAIN APP ******************/
void app_main(void)
{
    ESP_ERROR_CHECK(nvs_flash_init());
    ESP_ERROR_CHECK(esp_netif_init());
    ESP_ERROR_CHECK(esp_event_loop_create_default());

    /* Init sensor */
    if (dht20_init(&g_bus, &g_dev) != ESP_OK) {
        ESP_LOGE(TAG, "DHT20 init failed");
        return;
    }
    ESP_LOGI(TAG, "DHT20 OK");

    /* Start SoftAP */
    init_softap();

    /* Start HTTPS server (always on, no STA needed) */
    start_webserver();
}
