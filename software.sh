#!/usr/bin/env bash

### connect ssh prerequisites
# set password passwd
# check if
passwd
nano /etc/ssh/sshd_config # check if PermitRootLogin yes exist and is uncommented
systemctl start sshd.service
ip a # for checking ip


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


### MIRRORS!!!
nano /etc/pacman.d/mirrorlist # move lithuania and some other to the top

pacstrap -i /mnt base

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

pacman -S grub-bios linux-headers linux-lts linux-lts-headers wpa_supplicant wireless_tools

ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime
hwclock --systohc

# uncomment
# lt_LT.UTF-8 UTF-8
# en_US.UTF-8 UTF-8
nano /etc/locale.gen
Locale-gen

# localectl set-locale LANG="en_US.UTF-8"
# and restart - gnome terminal fails to start if it’s not in place


echo "DagoDragony" >> /etc/hostname
echo -e '127.0.0.1\tlocalhost' >> /etc/hosts
echo -e "::1\t\tlocalhost" >> /etc/hosts


grub-install --target=i386-pc --recheck /dev/sda
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg

# exit
umount /mnt/home
umount /mnt

reboot


# setting network back
ip a
ip link set dev enp0s25 up # LAN on
dhcpcd

pacman -S openssh
systemctl enable sshd.service
nano /etc/ssh/sshd_config # set PermitRootLogin yes


pacman -S intel-ucode
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S xf86-video-intel

useradd -m -g users -s /bin/bash dago
Passwd dago
pacman -S sudo
nano /etc/sudoers # add  line like root, but not root


Sudo pacman -S xorg-xinit
pacman -Sy gnome gnome-extra
systemctl enable gdm.service

pacman -Sy archlinux-wallpaper

# enable internet on boot
systemctl enable dhcpcd

# set HandleLidSwitch=ignore
nano /etc/systemd/logind.conf
# Remove user
Sudo su -
Userdel dago
Userdel -r dago # also deletes user home directory and mail spool
# Arch User Repository (AUR)
sudo nano /etc/pacman.conf
# add
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
#
sudo pacman -Sy yaourt
sudo pacman -S base-devel

yaourt -S slack-desktop
yaourt -S skypeforlinux-stable-bin

sudo pacman -S jdk8-openjdk
sudo pacman -S intellij-idea-community-edition
sudo pacman -S git
sudo pacman -S chromium
sudo pacman -S transmission-gtk # torrent client
sudo pacman -S xfce4-goodies # screenshots only




# i3 stuff
Sudo pacman -S i3
Sudo pacman -S i3lock
Sudo pacman -S dmenu
sudo pacman -S xorg-xrandr
sudo pacman -S redshift

Mkdir ~/bin
nano ~/bin/startup
# copy and past these
xrandr --output DP2-1 --pos 0x0
xrandr --output DP2-2 --pos 1920x0
xrandr --output DP2-3 --pos 3840x0

redshift -O 4000

Chmod 755 ~/bin/startup
# append
exec --no-startup-id "~/bin/startup"
bindsym $mod+l exec --no-startup-id i3lock -c 222222



bindsym --release Shift+Print exec xfce4-screenshooter -rc
exec --no-startup-id xfce4-clipman


# to file that is result of
I3-config-wizard # to know config file location

# tilix because for some reason terminal doesn’t work
Set font in i3 config
font pango:System San Francisco Display 10
https://github.com/supermarin/YosemiteSanFranciscoFont
Unzip it
Mv *.ttf ~/.fonts/
# setup font in applications
sudo pacman -S lxappearance
# go to lxappearance, do any default font action, and .gtkrc-2.0 file will be generated
Nano .gtkrc-2.0 # chyange gtk-font-name=”System San Francisco Display 13”
Nano .config/gtk-3.0/settings.ini # gtk-font-name=System San Francisco Display
https://github.com/bookercodes/setupi3/blob/master/config # for color settings
sudo pacman -S thunar # basically file explorer
https://github.com/horst3180/Arc-theme # windows theme
sudo pacman -S arc-gtk-theme
# go to lxappearance and select Arc-Dark, apply


sudo pacman -S vlc
# power saving stuff
sudo pacman -S tlp
systemctl enable tlp.service
systemctl enable tlp-sleep.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
# thinkpads only
sudo pacman -S tp_smapi
sudo pacman -S acpi_call
# wifi
Ip link
ip link set wlp3s0 up
sudo pacman -S networkmanager
sudo pacman -S network-manager-applet



sudo pacman -Syu

I3-msg exit # to logout










