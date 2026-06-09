#include "esp_efuse.h"
#include "esp_efuse_table.h"
#include "esp_system.h"
#include "esp_log.h"
#include "mbedtls/aes.h"
#include <string.h>
#include <stdlib.h>
#include "esp_random.h"

#define AES_KEY_SIZE 32        // 256 bits
#define AES_BLOCK_SIZE 16      // AES works on 16-byte blocks
#define EFUSE_BLOCK EFUSE_BLK_KEY5

static const char *TAG = "AES_EFUSE";

void example_aes_encrypt_decrypt_with_efuse_key() {
    uint8_t efuse_key[AES_KEY_SIZE] = {0};
    esp_err_t err;

    // Read key from efuse
    err = esp_efuse_read_block(EFUSE_BLOCK, efuse_key, 0, 256);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "Failed to read eFuse key: %s", esp_err_to_name(err));
        return;
    }

    ESP_LOGI(TAG, "eFuse key read successfully.");

    //-------------------------------------------------------------------
    // PLAINTEXT DE TAMANHO ARBITRÁRIO
    //-------------------------------------------------------------------
    const char *msg = "ConnectedDevices12345678901234567890";
    size_t msg_len = strlen(msg);

    ESP_LOGI(TAG, "Original plaintext (%u bytes): %s", msg_len, msg);

    //-------------------------------------------------------------------
    // PKCS#7 padding
    //-------------------------------------------------------------------
    size_t pad_len = AES_BLOCK_SIZE - (msg_len % AES_BLOCK_SIZE);
    size_t padded_len = msg_len + pad_len;

    uint8_t *padded = malloc(padded_len);
    memcpy(padded, msg, msg_len);
    memset(padded + msg_len, pad_len, pad_len);

    //-------------------------------------------------------------------
    // BUFFER PARA CIPHER
    //-------------------------------------------------------------------
    uint8_t *ciphertext = malloc(padded_len);

    //-------------------------------------------------------------------
    // CBC NEEDS AN IV (16 bytes)
    //-------------------------------------------------------------------
    uint8_t iv[16];
    for (int i = 0; i < 16; i++)
        iv[i] = esp_random() & 0xFF;

    uint8_t iv_dec[16];
    memcpy(iv_dec, iv, 16);


    //-------------------------------------------------------------------
    // AES-256 ECB: cifrar bloco a bloco
    //-------------------------------------------------------------------
    mbedtls_aes_context aes;
    mbedtls_aes_init(&aes);
    mbedtls_aes_setkey_enc(&aes, efuse_key, AES_KEY_SIZE * 8);

    mbedtls_aes_crypt_cbc(&aes, MBEDTLS_AES_ENCRYPT,
                          padded_len, iv, padded, ciphertext);

    ESP_LOGI(TAG, "IV:");
    ESP_LOG_BUFFER_HEX(TAG, iv_dec, 16);

    ESP_LOGI(TAG, "Ciphertext (%u bytes):", padded_len);
    ESP_LOG_BUFFER_HEX(TAG, ciphertext, padded_len);

    //-------------------------------------------------------------------
    // DECIFRAR BLOCO A BLOCO
    //-------------------------------------------------------------------
    uint8_t *decrypted = malloc(padded_len);

    mbedtls_aes_setkey_dec(&aes, efuse_key, AES_KEY_SIZE * 8);

    mbedtls_aes_crypt_cbc(&aes, MBEDTLS_AES_DECRYPT,
                          padded_len, iv_dec, ciphertext, decrypted);

    //-------------------------------------------------------------------
    // REMOVER PADDING
    //-------------------------------------------------------------------
    uint8_t last = decrypted[padded_len - 1];
    size_t final_len = padded_len - last;
    decrypted[final_len] = 0;  // terminar string

    ESP_LOGI(TAG, "Decrypted text: %s", decrypted);

    //-------------------------------------------------------------------
    // LIMPEZA
    //-------------------------------------------------------------------
    mbedtls_aes_free(&aes);
    free(padded);
    free(ciphertext);
    free(decrypted);
}

void app_main(void) {
    example_aes_encrypt_decrypt_with_efuse_key();
}
