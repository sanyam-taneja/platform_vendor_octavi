# Inherit common Octavi-OS stuff
$(call inherit-product, vendor/octavi/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
