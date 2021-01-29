#!/usr/bin/env bash

set -v

echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download          "
echo "-------------------------------------------------"
timedatectl set-ntp true
pacman -Sy
pacman -S --noconfirm pacman-contrib # for ranking mirrors
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -sL "https://archlinux.org/mirrorlist/?country=LT&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

read a
echo -e "\nInstalling prereqs...\n$HR"
pacman -S --noconfirm gptfdisk btrfs-progs

read a
echo "-------------------------------------------------"
echo "-------select your disk to format----------------"
echo "-------------------------------------------------"
lsblk
echo "Please enter disk: (example /dev/sda)"
read DISK
echo "--------------------------------------"
echo -e "\nFormatting disk...\n$HR"
echo "--------------------------------------"

# disk prep
sgdisk -Z ${DISK} # zap all on disk
sgdisk -a 2048 -o ${DISK} # new gpt disk 2048 alignment
partprobe

read a
# create partitions
sgdisk -n 1:0:+1000M ${DISK} # boot partition
sgdisk -n 2:0:+2000M ${DISK} # swap partition
sgdisk -n 3:0:-10G   ${DISK} # main partition

read a
sgdisk -t 1:ef00 ${DISK} # Efi system partition
sgdisk -t 2:8200 ${DISK} # Linux swap
sgdisk -t 1:8304 ${DISK} # Linux x86-x64 root (/)

read a
# label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"SWAP"    ${DISK}
sgdisk -c 3:"ROOT"    ${DISK}

read a
# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"

mkswap "${DISK}2"
swapon "${DISK}2"

read a
cryptsetup -y -v luksFormat "${DISK}3"
cryptsetup open "${DISK}3" cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

read a
mkdir /mnt/boot
mount "${DISK}1" /mnt/boot

read a
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
reboot##
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