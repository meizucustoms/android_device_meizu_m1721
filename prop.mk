#
# system.prop for m1721
#

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
af.fast_track_multiplier=1 \
audio_hal.period_size=480 \
ro.qc.sdk.audio.fluencetype=fluence \
persist.audio.fluence.voicecall=true \
persist.audio.fluence.voicerec=false \
persist.audio.fluence.speaker=false \
tunnel.audio.encode=false \
audio.offload.buffer.size.kb=64 \
audio.offload.min.duration.secs=30 \
audio.offload.video=false \
audio.offload.pcm.16bit.enable=true \
audio.offload.pcm.24bit.enable=true \
audio.offload.track.enable=true \
audio.deep_buffer.media=true \
audio.heap.size.multiplier=7 \
use.voice.path.for.pcm.voip=true \
audio.offload.multiaac.enable=true \
audio.dolby.ds2.enabled=true \
audio.dolby.ds2.hardbypass=true \
audio.offload.multiple.enabled=false \
audio.offload.passthrough=false \
ro.qc.sdk.audio.ssr=false \
audio.offload.gapless.enabled=true \
audio.safx.pbe.enabled=true \
audio.parser.ip.buffer.size=262144 \
audio.playback.mch.downsample=true \
use.qti.sw.alac.decoder=true \
use.qti.sw.ape.decoder=true \
audio.pp.asphere.enabled=false \
voice.playback.conc.disabled=true \
voice.record.conc.disabled=false \
voice.voip.conc.disabled=true \
voice.conc.fallbackpath=deep-buffer \
persist.speaker.prot.enable=true \
qcom.hw.aac.encoder=true \
flac.sw.decoder.24bit.support=true

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
bluetooth.hfp.client=1

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
persist.vendor.camera.display.lmax=1280x720 \
persist.vendor.camera.display.umax=1920x1080 \
camera.lowpower.record.enable=1 \
vidc.enc.dcvs.extra-buff-count=2 \
persist.vendor.camera.HAL3.enabled=1 \
camera.aux.packagelist=org.codeaurora.snapcam \
camera.hal1.packagelist=com.skype.raider,com.google.android.talk

#VM
PRODUCT_PROPERTY_OVERRIDES += \
dalvik.vm.heapstartsize=16m \
dalvik.vm.heapgrowthlimit=192m \
dalvik.vm.heapsize=512m \
dalvik.vm.heaptargetutilization=0.75 \
dalvik.vm.heapminfree=4m \
dalvik.vm.heapmaxfree=8m

# Cne
PRODUCT_PROPERTY_OVERRIDES += \
persist.vendor.cne.feature=1

# Coresight
PRODUCT_PROPERTY_OVERRIDES += \
persist.debug.coresight.config=stm-events

# Console
PRODUCT_PROPERTY_OVERRIDES += \
persist.console.silent.config=1

# Cpu in core control
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.qti.core_ctl_min_cpu=2 \
ro.vendor.qti.core_ctl_max_cpu=4

# Display
PRODUCT_PROPERTY_OVERRIDES += \
debug.sf.hw=0 \
debug.egl.hw=0 \
persist.hwc.mdpcomp.enable=true \
debug.mdpcomp.logs=0 \
dalvik.vm.heapsize=36m \
dev.pm.dyn_samplingrate=1 \
persist.demo.hdmirotationlock=false \
debug.enable.sglscale=1 \
debug.gralloc.enable_fb_ubwc=1 \
ro.qualcomm.cabl=0 \
ro.opengles.version=196610

# Buttons
PRODUCT_PROPERTY_OVERRIDES += \
qemu.hw.mainkeys=1

# DRM
PRODUCT_PROPERTY_OVERRIDES += \
drm.service.enabled=true

# Fingerprint
PRODUCT_PROPERTY_OVERRIDES += \
persist.qfp=false

# Fm
PRODUCT_PROPERTY_OVERRIDES += \
ro.fm.transmitter=false \

# Frp
PRODUCT_PROPERTY_OVERRIDES += \
ro.frp.pst=/dev/block/bootdevice/by-name/config

# HWUI
PRODUCT_PROPERTY_OVERRIDES += \
ro.hwui.texture_cache_size=48 \
ro.hwui.layer_cache_size=32 \
ro.hwui.r_buffer_cache_size=8 \
ro.hwui.path_cache_size=32 \
ro.hwui.gradient_cache_size=3 \
ro.hwui.drop_shadow_cache_size=6 \
ro.hwui.fbo_cache_size=25 \
ro.hwui.texture_cache_flushrate=0.4 \
ro.hwui.text_small_cache_width=1024 \
ro.hwui.text_small_cache_height=1024 \
ro.hwui.text_large_cache_width=2048 \
ro.hwui.text_large_cache_height=1024 \
debug.hwui.render_dirty_regions=true \
ro.hwui.disable_asset_atlas=true

# Media
PRODUCT_PROPERTY_OVERRIDES += \
media.msm8956hw=0 \
mm.enable.smoothstreaming=true \
mmp.enable.3g2=true \
media.aac_51_output_enabled=true \
av.debug.disable.pers.cache=1 \
persist.mm.sta.enable=0 \
vidc.enc.disable_bframes=1 \
vidc.enc.disable_pframes=1 \
vidc.disable.split.mode=1 \
vidc.dec.downscalar_width=1920 \
vidc.dec.downscalar_height=1088 \
vidc.enc.disable.pq=true

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
ro.sys.fw.dex2oat_thread_count=4 \
ro.vendor.extension_library=libqti-perfd-client.so \
ro.sys.fw.bservice_enable=true \
ro.sys.fw.bservice_limit=5 \
ro.sys.fw.bservice_age=5000

# QTI Performance
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.gt_library=libqti-gt.so \
ro.vendor.at_library=libqti-at.so \

# Netmgrd
PRODUCT_PROPERTY_OVERRIDES += \
ro.use_data_netmgrd=true \
persist.data.netmgrd.qos.enable=true \
persist.data.mode=concurrent

# Nitz
PRODUCT_PROPERTY_OVERRIDES += \
persist.rild.nitz_plmn= \
persist.rild.nitz_long_ons_0= \
persist.rild.nitz_long_ons_1= \
persist.rild.nitz_long_ons_2= \
persist.rild.nitz_long_ons_3= \
persist.rild.nitz_short_ons_0= \
persist.rild.nitz_short_ons_1= \
persist.rild.nitz_short_ons_2= \
persist.rild.nitz_short_ons_3=

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
rild.libpath=/vendor/lib64/libril-qc-qmi-1.so \
rild.libargs=-d /dev/smd0 \
DEVICE_PROVISIONED=1 \
ril.subscription.types=NV,RUIM \
persist.radio.flexmap_type=nw_mode \
persist.radio.DROPSETENABLE=1 \
persist.radio.force_on_dc=true \
persist.radio.facnotsup_as_nonw=1 \
persist.radio.apm_sim_not_pwdn=1 \
persist.radio.sib16_support=1 \
persist.radio.custom_ecc=1 \
persist.radio.multisim.config=dsds \
persist.radio.report_codec=0 \
persist.radio.fourgOff=1 \
persist.radio.calls.on.ims=0 \
persist.radio.jbims=0 \
persist.radio.csvt.enabled=false \
persist.radio.rat_on=combine \
persist.radio.mt_sms_ack=20 \
telephony.lteOnCdmaDevice=1 \
ro.telephony.default_network=22,20

# Time Services
PRODUCT_PROPERTY_OVERRIDES += \
persist.timed.enable=true

# Usb
PRODUCT_PROPERTY_OVERRIDES += \
persist.sys.usb.config=diag,serial_smd,rmnet_ipa,adb

# Unsorted properties
PRODUCT_PROPERTY_OVERRIDES += \
ro.cutoff_voltage_mv=3100 \
ro.emmc_size=16GB \
ro.sys.fw.use_trim_settings=true \
ro.sys.fw.empty_app_percent=50 \
ro.sys.fw.trim_empty_percent=100 \
ro.sys.fw.trim_cache_percent=100 \
ro.sys.fw.trim_enable_memory=2147483648 \
ro.memperf.lib=libmemperf.so \
ro.memperf.enable=false \
ro.qualcomm.svi=1 \
ro.qcom.dpps.sensortype=2 \
config.svi.xml=1 \
config.svi.path=/system/etc/svi_config.xml \
config.svi.xml.print=1
