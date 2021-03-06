PLATFORM_PFW_CONFIG_PATH := $(call my-dir)

# The file included defines the following variable
# - $(PFW_TUNING_ALLOWED)
# It allows to set or not the tuning flags according to the type of build.
include device/intel/common/audio/parameter-framework/AndroidBoard.mk

LOCAL_PATH := $(PLATFORM_PFW_CONFIG_PATH)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.route.baytrail
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
        RouteParameterFramework.xml \
        RouteClass-bytcr.xml \
        RouteConfigurableDomains-bytcr.xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.$(TARGET_DEVICE)
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
        parameter-framework.audio.$(TARGET_DEVICE).nodomains \
        AudioConfigurableDomains-$(SOUND_CARD_NAME).xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.$(TARGET_DEVICE).nodomains
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES :=  \
        parameter-framework.audio.baytrail \
        AudioClass-$(SOUND_CARD_NAME).xml \
        AudioParameterFramework.xml

include $(BUILD_PHONY_PACKAGE)

##################################################

######### Route PFW #########
######### Route Structures #########

include $(CLEAR_VARS)
LOCAL_MODULE := RouteSubsystem-bytcr.xml
LOCAL_MODULE_STEM := RouteSubsystem.xml
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
LOCAL_REQUIRED_MODULES := \
    RouteSubsystem-CommonCriteria.xml \
    RouteSubsystem-RoutesTypes.xml
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := RouteClass-bytcr.xml
LOCAL_MODULE_STEM := RouteClass.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Structure/Route
LOCAL_SRC_FILES := Structure/Route/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

######### Route Settings #########
include $(CLEAR_VARS)
LOCAL_MODULE := RouteConfigurableDomains-bytcr.xml
LOCAL_MODULE_STEM := RouteConfigurableDomains.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_RELATIVE_PATH := parameter-framework/Settings/Route

ifeq ($(pfw_rebuild_settings),true)
include $(CLEAR_PFW_VARS)
# Refresh domain file
LOCAL_REQUIRED_MODULES := \
    RouteParameterFramework.xml \
    RouteClass-bytcr.xml \
    RouteSubsystem-common-bytcr.xml \
    RouteSubsystem-bytcr.xml \

PFW_COPYBACK := Settings/Route/$(LOCAL_MODULE)
PFW_TOPLEVEL_FILE := $(TARGET_OUT_ETC)/parameter-framework/RouteParameterFramework.xml
PFW_CRITERIA_FILE := $(COMMON_PFW_CONFIG_PATH)/RouteCriteria.txt
PFW_EDD_FILES := \
    $(PLATFORM_PFW_CONFIG_PATH)/Settings/Route/routes-applicability.pfw \
    $(PLATFORM_PFW_CONFIG_PATH)/Settings/Route/routes-configuration.pfw \
    $(COMMON_PFW_CONFIG_PATH)/Settings/Route/parameters.pfw

include $(BUILD_PFW_SETTINGS)

else
# Use the existing file
LOCAL_SRC_FILES := Settings/Route/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)
endif
