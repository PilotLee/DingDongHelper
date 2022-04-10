export THEOS_DEVICE_IP={ip}
export THEOS_DEVICE_PORT={port}


TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DDMaicaiHelper

DDMaicaiHelper_FILES = Tweak.x
DDMaicaiHelper_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
