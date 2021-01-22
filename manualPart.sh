#!/usr/bin/env bash

### disk creation
fdisk -l
fdisk /dev/sda
# 1p +1G for /boot
# 2p +2G for swap
#	3p rest for /


mkfs.ext4 /dev/sda1

mkswap /dev/sda2
swapon /dev/sda2

cryptsetup -y -v luksFormat /dev/sda3
cryptsetup open /dev/sda3 cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap -i /mnt base base-devel

genfstab -U /mnt >> /mnt/etc/fstab

##
arch-chroot /mnt

pacman -Syy
# pacman -S grub-bios ???
#pacman -S wpa_supplicant wireless_tools

pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector --country Lithuania -p http --save /etc/pacman.d/mirrorlist

pacman -S linux-headers linux-lts linux-lts-headers

pacman -S grub

pacman -S neovim
nvim /etc/default/grub
# add GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:cryptroot"

nvim /etc/mkinitcpio.conf
# add HOOKS="base udev autodetect modconf block encrypt filesystems keyboard fsck"

mkinitcpio -p linux-lts

grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# for internet to be available on next run
pacman -S dhcpcd
systemctl enable dhcpcd

pacman -S git

# SETTINGS

echo "nameserver 1.1.1.1" >> /etc/resolvconf.conf

# change password
passwd

pacman -S openssh
systemctl start sshd
nvim /etc/ssh/sshd_config
# add "PermitRootLogin yes"

useradd -m dago
passwd dago

exit
reboot