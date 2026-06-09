idf_component_register(
    SRCS "dht20.c" "main.c"
    INCLUDE_DIRS "."
    PRIV_REQUIRES esp_https_server esp_wifi nvs_flash esp_eth protocol_examples_common esp_driver_i2c 
    EMBED_TXTFILES "certs/servercert.pem"
                   "certs/prvtkey.pem"
)

