[main]
mixinsdir: device/intel/mixins/groups

[mapping]
product.mk: device.mk

[groups]
kernel: gmin64(path=gmin,loglevel=5,binary_name=bzImage, interactive_governor=false, dev-kernel=false)
boot-arch: minnow_max_mmc(uefi_arch=x86_64,fastboot=user,acpi_permissive=true)
sepolicy: intel
display-density: tv
dalvik-heap: tablet-7in-hdpi-1024
cpu-arch: slm
houdini: true
bugreport: default
graphics: ufo_gen7(use_opencl=true)
storage: 4xUSB-sda-emulated
ethernet: dhcp
audio: bytcr-rt564x
media: ufo
usb: host+acc
usb-gadget: g_android
touch: ft5x0x
navigationbar: true
device-type: tablet
gms: true
debug-tools: true
factory-scripts: true
charger: true
disk-bus: mmc-minnow
hdcpd: true
widevine: true
power: true
security: txei
lights: true
pdk: none
flashfiles: true
libmintel: true
memory: ksm
memtrack: true
serialport: ttyS0
suspend: never
bluetooth: btusb
