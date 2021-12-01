#!/bin/bash

# arguments: $RELEASE $LINUXFAMILY $BOARD $BUILD_DESKTOP
#
# This is the image customization script

# NOTE: It is copied to /tmp directory inside the image
# and executed there inside chroot environment
# so don't reference any files that are not already installed

# NOTE: If you want to transfer files between chroot and host
# userpatches/overlay directory on host is bind-mounted to /tmp/overlay in chroot
# The sd card's root path is accessible via $SDCARD variable.

RELEASE=$1
LINUXFAMILY=$2
BOARD=$3
BUILD_DESKTOP=$4

main() {
	echo "adjusting /boot"
	local dtbpath=$(realpath /boot/dtb)
	rm -rf /boot/dtb
	cp -r ${dtbpath} /boot/dtb
	mv /boot/dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb /boot
	sed -i -e '/fdtfile=/d' /boot/armbianEnv.txt
	echo fdtfile=amlogic/meson-gxl-s905d-phicomm-n1.dtb >> /boot/armbianEnv.txt
	rm -rf /boot/boot.bmp /boot/uImage /boot/armbian_first_run.txt.template
	rm -rf /boot/dtb/rockchip /boot/dtb/amlogic/*.* /boot/dtb/amlogic/overlay
	mv /boot/meson-gxl-s905d-phicomm-n1.dtb /boot/dtb/amlogic/

	rsync -a /tmp/overlay/* /

	mkimage -C none -A arm -T script -d /boot/emmc_autoscript.cmd /boot/emmc_autoscript
	mkimage -C none -A arm -T script -d /boot/s905_autoscript.cmd /boot/s905_autoscript
	cp /boot/u-boot-n1.bin /boot/u-boot.ext
	cp /boot/u-boot-n1.bin /boot/u-boot.emmc

	sync
}

main "$@"
