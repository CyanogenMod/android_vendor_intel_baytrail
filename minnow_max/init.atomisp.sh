#!/system/bin/sh

# This script is started from init.rc on early-boot

# Load atomisp driver and dependencies in the proper order.  Note that
# we cannot do this from init.rc directly because atomisp wants to
# make a request_firmware call from its module init function, which
# init won't service until the module load completes!
insmod /system/lib/modules/ov5693.ko
insmod /system/lib/modules/mt9m114.ko
insmod /system/lib/modules/videobuf-core.ko
insmod /system/lib/modules/videobuf-vmalloc.ko
insmod /system/lib/modules/atomisp-css2400b0_v21.ko
