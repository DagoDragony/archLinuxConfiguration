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

echo -e "\nInstalling prereqs...\n$HR"
pacman -S --noconfirm gptfdisk

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

# create partitions
sgdisk -n 1:0:+1000M ${DISK} # boot partition
sgdisk -n 2:0:+2000M ${DISK} # swap partition
sgdisk -n 3:0:-10G   ${DISK} # main partition

sgdisk -t 1:ef00 ${DISK} # Efi system partition
sgdisk -t 2:8200 ${DISK} # Linux swap
sgdisk -t 1:8304 ${DISK} # Linux x86-x64 root (/)

# label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"SWAP"    ${DISK}
sgdisk -c 3:"ROOT"    ${DISK}

# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"

mkswap "${DISK}2"
swapon "${DISK}2"

cryptsetup -y -v luksFormat "${DISK}3"
cryptsetup open "${DISK}3" cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt

mkdir /mnt/boot
mount "${DISK}1" /mnt/boot

pacstrap /mnt base base-devel linux linux-firmware vim nano sudo --noconfirm --needed

genfstab -U /mnt >> /mnt/etc/fstab

cp Installers/archChroot.sh /mnt/root

arch-chroot /mnt /root/archChroot.sh

umount -R /mnt

reboot