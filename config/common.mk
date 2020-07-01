# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= Octavi-OS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# SetupWizard
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.enable_assist_gesture_training=true \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.theme=glif_v3_light

# IME
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/octavi/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/octavi/prebuilt/common/bin/50-octavi.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-octavi.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/octavi/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/octavi/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# octavi-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/octavi-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/octavi-sysconfig.xml

# Copy all Octavi-specific init rc files
$(foreach f,$(wildcard vendor/octavi/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/octavi/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Octavi!
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/privapp-permissions-octavi.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-octavi.xml \
    vendor/octavi/config/permissions/privapp-permissions-octavi-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-octavi.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/octavi-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/octavi-hiddenapi-package-whitelist.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/octavi/config/permissions/octavi-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/octavi-power-whitelist.xml

# Include AOSP audio files
include vendor/octavi/config/aosp_audio.mk

# Include Octavi audio files
include vendor/octavi/config/octavi_audio.mk

# Include Google fonts
include vendor/octavi/config/fonts.mk

# Include Packages
include vendor/octavi/config/packages.mk

# Include Bootanimation
include vendor/octavi/config/bootanimation.mk

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/octavi/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# AOSP packages
PRODUCT_PACKAGES += \
    ExactCalculator \
    Exchange2 \
    Terminal \
    ThemePicker

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# LatinIME lib
ifneq ($(WITH_GAPPS),true)
PRODUCT_PACKAGES += \
    libjni_latinimegoogle
endif

# Extra tools in Zenx
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_OCTAVI_CHARGER),true)
PRODUCT_PACKAGES += \
    octavi_charger_res_images \
    font_log.png \
    libhealthd.octavi
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/octavi/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/octavi/overlay/common

# Allows registering device to Google easier for gapps
# Integrates package for easier Google Pay fixing
PRODUCT_PACKAGES += \
    sqlite3

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/octavi/config/partner_gms.mk
-include vendor/octavi/config/version.mk
