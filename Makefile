ifeq ($(ROOTLESS),1)
THEOS_PACKAGE_SCHEME=rootless
endif

ARCHS = arm64
INSTALL_TARGET_PROCESSES = YouTubeMusic
TARGET = iphone:clang:latest:12.0
PACKAGE_VERSION = 0.0.1

THEOS_DEVICE_IP = 192.168.1.9
THEOS_DEVICE_PORT = 22

TWEAK_DISPLAY_NAME = "SponsorBlock"

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTMSponsorBlock

$(TWEAK_NAME)_FILES = Tweak.x Settings.x Utils/NSBundle+YTMSb.m Utils/YTMSbUserDefaults.m
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -DTWEAK_NAME="\"${TWEAK_DISPLAY_NAME}\""

include $(THEOS_MAKE_PATH)/tweak.mk
