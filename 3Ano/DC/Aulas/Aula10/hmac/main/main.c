#include "esp_efuse.h"
#include "esp_efuse_table.h"
#include "esp_system.h"
#include "esp_log.h"
#include "mbedtls/md.h"

#define AES_KEY_SIZE 32       // 256 bits
#define EFUSE_BLOCK  EFUSE_BLK_KEY5  // BLOCK_KEY5 on ESP32-C6

static const char *TAG = "HMAC_SHA256";

void compute_hmac_sha256(const uint8_t *key, size_t key_len,
                         const uint8_t *message, size_t message_len,
                         uint8_t *mac_out /* should be 32 bytes */)
{
    const mbedtls_md_info_t *md_info = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
    if (md_info == NULL) {
        ESP_LOGE(TAG, "Failed to get SHA256 info");
        return;
    }

    int ret = mbedtls_md_hmac(md_info,
                               key, key_len,
                               message, message_len,
                               mac_out);
    if (ret != 0) {
        ESP_LOGE(TAG, "mbedtls_md_hmac failed with code: %d", ret);
    }
}

void app_main(void) {
    uint8_t efuse_key[AES_KEY_SIZE] = {0};
    esp_err_t err;


    err = esp_efuse_read_block(EFUSE_BLOCK, efuse_key, 0, 256);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "Failed to read eFuse key: %s", esp_err_to_name(err));
        return;
    }

    uint8_t mac[32] = {0};  
    uint8_t message[]  = "Connected Devices 2025/2026";  // variable length message

    compute_hmac_sha256(efuse_key, sizeof(efuse_key), (const uint8_t *)message, strlen((char *) message), mac);

    ESP_LOGI(TAG, "HMAC-SHA256 output:");
    ESP_LOG_BUFFER_HEX(TAG, mac, sizeof(mac));
}
