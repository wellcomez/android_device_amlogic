# Copyright (C) 2011 Amlogic Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for Meson reference board.
#

# Inherit from those products. Most specific first.

$(call inherit-product, device/amlogic/common/products/mbox/product_mbox.mk)
$(call inherit-product, device/amlogic/m201C/device.mk)

# m201C:

NUM_FRAMEBUFFER_SURFACE_BUFFERS := 2

PRODUCT_PROPERTY_OVERRIDES += \
        sys.fb.bits=32

#disable hwui debug for gpu in costdown project
#We recommend setting of “debug.hwui.render_dirty_regions = FALSE”
#under Android. When set to TRUE (this is the default value)
#this flag sets EGL_SWAP_BEHAVIOR_PRESERVED_BIT in eglSwapBuffers
#which will end up preserving the whole frame
#causing a significant increase in memory bandwidth
#and decrease in performance.
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false

PRODUCT_NAME := m201C
PRODUCT_DEVICE := m201C
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on m201C
PRODUCT_MANUFACTURER := amlogic


WITH_LIBPLAYER_MODULE := false

#########################################################################
#
#                                                Dm-Verity
#
#########################################################################
#BUILD_WITH_DM_VERITY := true
ifeq ($(BUILD_WITH_DM_VERITY), true)
PRODUCT_COPY_FILES += \
    device/amlogic/m201C/fstab.verity.amlogic:root/fstab.amlogic
else
PRODUCT_COPY_FILES += \
    device/amlogic/m201C/fstab.amlogic:root/fstab.amlogic
endif
#########################################################################
#
#                                                WiFi
#
#########################################################################

WIFI_MODULE := rtl8189es
#WIFI_AP6xxx_MODULE := AP6210
include device/amlogic/common/wifi.mk

# Change this to match target country
# 11 North America; 14 Japan; 13 rest of world
PRODUCT_DEFAULT_WIFI_CHANNELS := 11

ifeq ($(WIFI_MODULE), AP6335)
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/wifi/config.txt:system/etc/wifi/config.txt
endif


#########################################################################
#
#                                                Bluetooth
#
#########################################################################

BOARD_HAVE_BLUETOOTH := false
BLUETOOTH_MODULE :=
include device/amlogic/common/bluetooth.mk

#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

#PRODUCT_PACKAGES += libbt-vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

# Audio
#
BOARD_ALSA_AUDIO=tiny
include device/amlogic/common/audio.mk

#########################################################################
#
#                                                Camera
#
#########################################################################

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml

#########################################################################
#
#                                                PlayReady drm
#
#########################################################################
#BUILD_WITH_PLAYREADY_DRM := true
ifeq ($(BUILD_WITH_PLAYREADY_DRM), true)
#playready license process in smoothstreaming(default)
BOARD_PLAYREADY_LP_IN_SS := true
#BOARD_PLAYREADY_TVP:= true
endif
#########################################################################
#
#                                                Verimatrix DRM
##########################################################################
#verimatrix web
BUILD_WITH_VIEWRIGHT_WEB := false
#verimatrix stb
BUILD_WITH_VIEWRIGHT_STB := false
#########################################################################


$(call inherit-product, device/amlogic/common/media.mk)

#########################################################################
#
#                                                languages
#
#########################################################################

# For all locales, $(call inherit-product, build/target/product/languages_full.mk)
PRODUCT_LOCALES := en_US en_AU en_IN fr_FR it_IT es_ES et_EE de_DE nl_NL cs_CZ pl_PL ja_JP \
  zh_TW zh_CN zh_HK ru_RU ko_KR nb_NO es_US da_DK el_GR tr_TR pt_PT pt_BR rm_CH sv_SE bg_BG \
  ca_ES en_GB fi_FI hi_IN hr_HR hu_HU in_ID iw_IL lt_LT lv_LV ro_RO sk_SK sl_SI sr_RS uk_UA \
  vi_VN tl_PH ar_EG fa_IR th_TH sw_TZ ms_MY af_ZA zu_ZA am_ET hi_IN en_XA ar_XB fr_CA km_KH \
  lo_LA ne_NP si_LK mn_MN hy_AM az_AZ ka_GE my_MM mr_IN ml_IN is_IS mk_MK ky_KG eu_ES gl_ES \
  bn_BD ta_IN kn_IN te_IN uz_UZ ur_PK kk_KZ

#################################################################################
#
#                                                PPPOE
#
#################################################################################

BUILD_WITH_PPPOE := true

ifeq ($(BUILD_WITH_PPPOE),true)
PRODUCT_PACKAGES += \
    PPPoE \
    libpppoejni \
    libpppoe \
    pppoe_wrapper \
    pppoe \
    droidlogic.frameworks.pppoe \
    droidlogic.external.pppoe \
    droidlogic.external.pppoe.xml
PRODUCT_PROPERTY_OVERRIDES += \
    ro.platform.has.pppoe=true
endif

#################################################################################
#
#                                                DEFAULT LOWMEMORYKILLER CONFIG
#
#################################################################################
BUILD_WITH_LOWMEM_COMMON_CONFIG := true

BOARD_USES_USB_PM := true
