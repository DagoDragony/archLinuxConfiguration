#!/usr/bin/env bash

### disk creation
fdisk -l
fdisk /dev/sda
#	o - wipe everything
#	1p 50G
#	a - set as boot
#	2p 2G
#	type 82 (swap)
#	3p
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3

mkswap /dev/sda2
swapon /dev/sda2

mount /dev/sda1 /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount /dev/sda3 /mnt/home

pacstrap -i /mnt base

genfstab -U /mnt >> /mnt/etc/fstab

##
arch-chroot /mnt

# pacman -S grub-bios ???
#pacman -S wpa_supplicant wireless_tools
pacman -S linux-headers linux-lts linux-lts-headers


pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# for internet to be available on next run
pacman -S dhcpcd
systemctl enable dhcpcd

pacman -S git

# SETTINGS

echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# change password
passwd

exit

reboot