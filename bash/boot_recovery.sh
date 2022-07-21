#!/bin/bash

# This script is based on a setup that is described by System76 (https://support.system76.com/articles/bootloader/)
#
# Do not run this script blindly. Look at the **Assumptions** and **What this script does**.
#
# Assumptions:
#   * You have an nvme drive as your boot drive
#   * Your / is stored encrypted with luks in /dev/nvme0n1p3
#   * Your /boot is stored un-encrypted in /dev/nvme0n1p2
#   * Your /boot/efi is stored un-encrypted in /dev/nvme0n1p1
#   * You are booting with `systemd-boot`.
#
# What this script does:
#   * Unlock /dev/nvme0n1p3
#   * Acticate volume groups 
#   * Mount system and chroot into it
#   * Re-install linux image
#   * Update initramfs
#   * Re-install systemd-boot in your system

echo 'Trying to unlock system'

sudo cryptsetup luksOpen /dev/nvme0n1p3 cryptdata
sudo lvscan
sudo vgchange -ay

echo 'Success'

echo 'Trying to mount system root'

sudo mount /dev/root/root /mnt
sudo mount /dev/nvme0n1p2 /mnt/boot
sudo mount /dev/nvme0n1p1 /mnt/boot/efi

echo 'Success'

echo 'Trying to prepare chroot'

for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done
sudo cp -n /etc/resolv.conf /mnt/etc/

echo 'Success'

echo 'Trying to chroot'

sudo chroot /mnt

echo 'Success'

echo 'Trying to re-install linux kernels'

apt install --reinstall linux-generic linux-headers-generic

echo 'Success'

echo 'Trying to update initramfs'

update-initramfs -c -k all

echo 'Success'

echo 'Trying to install systemd-boot'

exit
sudo bootctl --path=/mnt/boot/efi install

echo 'Success'

echo 'Trying to exit chroot'

exit

echo 'Success'

echo 'Trying to install systemd-boot'

sudo bootctl --path=/mnt/boot/efi install

echo 'Success'

echo 'You may reboot now'.
