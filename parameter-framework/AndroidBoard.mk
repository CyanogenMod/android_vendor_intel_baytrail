PLATFORM_PFW_CONFIG_PATH := $(call my-dir)

include device/intel/common/audio/parameter-framework/AndroidBoard.mk

LOCAL_PATH := $(PLATFORM_PFW_CONFIG_PATH)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.baytrail
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
        SstSubsystem-bytcr-rt56xx-common.xml \
        SysfsPmdownTimeSubsystem.xml \
        CommonAlgoTypes.xml \
        Gain.xml \
        VoiceVolume.xml \
        Dcr.xml \
        SbaFir.xml \
        SbaIir.xml \
        Lpro.xml \
        Mdrc.xml \
        ToneGenerator_V2_4.xml \
        ModuleVoiceProcessingLock_V1_0.xml \
        VoiceAlgos_Gen3_5
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.route.baytrail
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
        ParameterFrameworkConfigurationRoute-bytcr.xml \
        RouteSubsystem-common-bytcr.xml \
        RouteSubsystem-bytcr.xml \
        RouteClass-bytcr.xml \
        RouteConfigurableDomains-bytcr.xml
include $(BUILD_PHONY_PACKAGE)

##################################################

######### Audio Structures #########

include $(CLEAR_VARS)
LOCAL_MODULE := SstSubsystem-bytcr-rt56xx-common.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Structure/Audio
LOCAL_SRC_FILES := Structure/Audio/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)


include $(CLEAR_VARS)
LOCAL_MODULE := SysfsPmdownTimeSubsystem.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Structure/Audio
LOCAL_SRC_FILES := Structure/Audio/$(LOCAL_MODULE)
LOCAL_REQUIRED_MODULES := libfs-subsystem
include $(BUILD_PREBUILT)

######### Route PFW #########
# Route PFW top-level configuration file
include $(CLEAR_VARS)
LOCAL_MODULE := ParameterFrameworkConfigurationRoute-bytcr.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework
LOCAL_SRC_FILES := $(LOCAL_MODULE).in

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): MY_FILE := $(LOCAL_PATH)/$(LOCAL_MODULE).in
$(LOCAL_BUILT_MODULE): MY_TUNING_ALLOWED := $(PFW_TUNING_ALLOWED)
$(LOCAL_BUILT_MODULE):
	$(hide) mkdir -p $(dir $@)
	sed -e 's/@TUNING_ALLOWED@/$(MY_TUNING_ALLOWED)/' $(MY_FILE) > $@

######### Route Structures #########

include $(CLEAR_VARS)
LOCAL_MODULE := RouteSubsystem-bytcr.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Structure/Route
LOCAL_SRC_FILES := Structure/Route/$(LOCAL_MODULE).in
LOCAL_REQUIRED_MODULES := \
        RouteSubsystem-common-bytcr.xml \
        libroute-subsystem
include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): MY_FILE := $(LOCAL_PATH)/Structure/Route/$(LOCAL_MODULE).in
$(LOCAL_BUILT_MODULE): SOUND_CARD_NAME := $(SOUND_CARD_NAME)
$(LOCAL_BUILT_MODULE):
	$(hide) mkdir -p $(dir $@)
	sed -e 's/@SOUND_CARD_NAME@/$(SOUND_CARD_NAME)/' $(MY_FILE) > $@


include $(CLEAR_VARS)
LOCAL_MODULE := RouteSubsystem-common-bytcr.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Structure/Route
LOCAL_SRC_FILES := Structure/Route/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := RouteClass-bytcr.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Structure/Route
LOCAL_SRC_FILES := Structure/Route/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

######### Route Settings #########
include $(CLEAR_VARS)
LOCAL_MODULE := RouteConfigurableDomains-bytcr.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Settings/Route
LOCAL_SRC_FILES := Settings/Route/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)
