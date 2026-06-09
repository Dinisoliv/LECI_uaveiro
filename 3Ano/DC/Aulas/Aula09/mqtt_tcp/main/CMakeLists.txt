idf_component_register(SRCS "app_main.c"
                    PRIV_REQUIRES mqtt nvs_flash esp_netif
                    INCLUDE_DIRS ".")
target_add_binary_data(${PROJECT_NAME}.elf "main/mqtt_eclipseprojects_io.pem" TEXT)
