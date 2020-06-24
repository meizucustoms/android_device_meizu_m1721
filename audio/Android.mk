LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

AUDIO_PLATFORM := msm8916
MULTIPLE_HW_VARIANTS_ENABLED := true

LOCAL_SRC_FILES := \
	audio_hw.c \
	voice.c \
	platform_info.c \
	msm8916/platform.c \
	msm8916/hw_info.c

LOCAL_SRC_FILES += audio_extn/audio_extn.c \
                   audio_extn/utils.c \
                   audio_extn/fm.c \
                   audio_extn/hfp.c \
                   audio_extn/spkr_protection.c \
                   audio_extn/dolby.c \
                   audio_extn/dev_arbi.c \
                   audio_extn/soundtrigger.c
                   
LOCAL_SRC_FILES += voice_extn/voice_extn.c \
				   voice_extn/compress_voip.c
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_CFLAGS := \
	-DPLATFORM_MSM8916 \
	-DUSE_LL_AS_PRIMARY_OUTPUT \
	-DPCM_OFFLOAD_ENABLED \
	-DANC_HEADSET_ENABLED \
	-DHIFI_AUDIO_ENABLED \
	-DVBAT_MONITOR_ENABLED \
	-DFLUENCE_ENABLED \
	-DKPI_OPTIMIZE_ENABLED \
	-DFM_POWER_OPT \
	-DHFP_ENABLED \
	-DCUSTOM_STEREO_ENABLED \
	-DMULTI_VOICE_SESSION_ENABLED \
	-DCOMPRESS_VOIP_ENABLED \
	-DAUDIO_EXTN_FORMATS_ENABLED \
	-DSPKR_PROT_ENABLED \
	-DHW_VARIANTS_ENABLED \
	-DDS1_DOLBY_DDP_ENABLED \
	-DDS2_DOLBY_DAP_ENABLED \
	-DCOMPRESS_METADATA_NEEDED \
	-DFLAC_OFFLOAD_ENABLED \
	-DVORBIS_OFFLOAD_ENABLED \
	-DWMA_OFFLOAD_ENABLED \
	-DALAC_OFFLOAD_ENABLED \
	-DAPE_OFFLOAD_ENABLED \
	-DPCM_OFFLOAD_ENABLED_24 \
	-DAAC_ADTS_OFFLOAD_ENABLED \
	-DDEV_ARBI_ENABLED \
	-DDOLBY_ACDB_LICENSE \
	-DSOUND_TRIGGER_ENABLED \
	-DSOUND_TRIGGER_PLATFORM_NAME=msm8953

LOCAL_SHARED_LIBRARIES := \
	liblog \
	libcutils \
	libhardware \
	libtinyalsa \
	libtinycompress \
	libaudioroute \
	libdl \
	libaudioutils \
	libhardware \
	libexpat \
	libdiag

LOCAL_C_INCLUDES += \
	external/tinyalsa/include \
	external/tinycompress/include \
	system/media/audio_utils/include \
	external/expat/lib \
	hardware/libhardware/include \
	$(call include-path-for, audio-route) \
	$(call include-path-for, audio-effects) \
	$(LOCAL_PATH)/msm8916 \
	$(LOCAL_PATH)/audio_extn \
	$(LOCAL_PATH)/voice_extn \
	$(TARGET_OUT_HEADERS)/mm-audio/sound_trigger

LOCAL_CFLAGS += -Wall -Werror
LOCAL_CLANG_CFLAGS += -Wno-unused-variable -Wno-unused-function -Wno-missing-field-initializers

LOCAL_COPY_HEADERS_TO   := mm-audio
LOCAL_COPY_HEADERS      := audio_extn/audio_defs.h

LOCAL_MODULE := audio.primary.msm8953.meizu

LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
