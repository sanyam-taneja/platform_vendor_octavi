# Charger
ifeq ($(WITH_OCTAVI_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.octavi
endif

include vendor/octavi/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/octavi/config/BoardConfigQcom.mk
endif

include vendor/octavi/config/BoardConfigSoong.mk
