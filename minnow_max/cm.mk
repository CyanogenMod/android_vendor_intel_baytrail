# Boot animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/intel/baytrail/minnow_max/minnow_max.mk)

DEVICE_PACKAGE_OVERLAYS += device/intel/baytrail/minnow_max/overlay-cm

## Device identifier. This must come after all inclusions
PRODUCT_NAME := cm_minnow_max
PRODUCT_BRAND := Intel
PRODUCT_MODEL := Minnowboard Max

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=minnow_max \
    BUILD_FINGERPRINT=google/fugu/fugu:5.1/LMY47D/1743759:user/release-keys \
    PRIVATE_BUILD_DESC="fugu-user 5.1 LMY47D 1743759 release-keys"

# Wifi
BOARD_WLAN_DEVICE := bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
