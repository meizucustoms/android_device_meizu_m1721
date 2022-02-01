LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_ARCH),$(filter $(TARGET_ARCH),arm arm64))

include $(CLEAR_VARS)
LOCAL_MODULE := mm-image-codec_headers
LOCAL_EXPORT_C_INCLUDE_DIRS := \
	$(LOCAL_PATH)/qexif \
	$(LOCAL_PATH)/qomx_core
include $(BUILD_HEADER_LIBRARY)

include $(LOCAL_PATH)/qomx_core/Android.mk

endif
