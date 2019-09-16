# Inherit full common Octavi stuff
$(call inherit-product, vendor/octavi/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Octavi LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/octavi/overlay/dictionaries

$(call inherit-product, vendor/octavi/config/telephony.mk)
