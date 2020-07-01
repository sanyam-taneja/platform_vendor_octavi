# Inherit full common octavi stuff
$(call inherit-product, vendor/octavi/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include octavi LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/octavi/overlay/dictionaries

$(call inherit-product, vendor/octavi/config/telephony.mk)
