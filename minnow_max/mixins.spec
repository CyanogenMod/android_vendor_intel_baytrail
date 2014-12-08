[main]
mixinsdir: device/intel/mixins/groups

[mapping]
product.mk: device.mk

[groups]
kernel: gmin64(path=gmin,loglevel=5,binary_name=bzImage, interactive_governor=false, dev-kernel=false)
boot-arch: minnow_max_mmc(uefi_arch=x86_64,fastboot=user,acpi_permissive=true)
sepolicy: intel
display-density: low
dalvik-heap: tablet-7in-hdpi-1024
cpu-arch: slm
graphics: ufo_gen7(use_opencl=true)
storage: 4xUSB-sda-emulated
ethernet: dhcp
audio: hdmi+usb
media: ufo
usb: host+acc
navigationbar: true
device-type: tablet
factory-scripts: true
disk-bus: mmc-minnow
flashfiles: true
memory: ksm
serialport: ttyS0
suspend: never
bluetooth: btusb
adb_net: true
