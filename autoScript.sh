#!/usr/bin/env bash

### MIRRORS!!!
pacman -S pacman-contrib # helps to order mirror list by openning speeds
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors /etc/pacman.d/mirrorlist > /etc/pacman.d/rankedmirrorlist
cp /etc/pacman.d/rankedmirrorlist /etc/pacman.d/mirrorlist
# nano /etc/pacman.d/mirrorlist # move lithuania and some other to the top

# Time
ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime

hwclock --systohc
sudo pacman -S ntp # for clock synchronization, it really gets off

# Keyboard

# uncomment
echo "lt_LT.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# and restart - gnome terminal fails to start if it’s not in place
localectl set-locale LANG="en_US.UTF-8"

echo "DagoDragony" >> /etc/hostname
echo -e '127.0.0.1\tlocalhost' >> /etc/hosts
echo -e "::1\t\tlocalhost" >> /etc/hosts


### connect ssh prerequisites
# set password passwd
# check if

pacman -S openssh
echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config
systemctl enable sshd.service
systemctl start sshd.service

pacman -S intel-ucode

pacman -S xf86-video-intel

useradd -m -g users -s /bin/bash dago
Passwd dago

pacman -S sudo
echo "dago ALL=(ALL) ALL" >> /etc/sudoers

sudo pacman -S xorg-xinit
pacman -Sy gnome gnome-extra
# gnome terminal fails without gdm
systemctl enable gdm.service

pacman -Sy archlinux-wallpaper

# enable internet on boot
systemctl enable dhcpcd

echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf

# Remove user
#sudo su -
#Userdel dago
#Userdel -r dago # also deletes user home directory and mail spool

# Arch User Repository (AUR)
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf

sudo pacman -Sy yaourt
sudo pacman -S base-devel

yaourt -S slack-desktop

sudo pacman -S jdk8-openjdk
sudo pacman -S intellij-idea-community-edition
sudo pacman -S git
sudo pacman -S chromium

# deprecated after usage of new system
# sudo pacman -S transmission-gtk # torrent client

sudo pacman -S transmission-cli
yaourt -S transmission-remote-cli-git

sudo pacman -S xfce4-goodies # screenshots only

sudo pacman -S compton # transparency stuff

# i3 stuff
sudo pacman -S i3
sudo pacman -S i3lock
# preference is rofi
sudo pacman -S dmenu
sudo pacman -S rofi

sudo pacman -S xorg-xrandr
sudo pacman -S redshift

# to file that is result of
I3-config-wizard # to know config file location
sudo pacman -S i3blocks
cp /etc/i3blocks.conf ./
sudo pacman -S sysstat
sudo paman -S acpi # batery stats
sudo pacman -S alsa-utils # sound
sudo pacman -S extra/pulseaudio-alsa

########## FONTS
# Set font in i3 config
#font pango:System San Francisco Display 10

#curl https://github.com/supermarin/YosemiteSanFranciscoFont --output ~/Downloads/YosemiteSanFranciscoFont
#Unzip it
#Mv *.ttf ~/.fonts/

# install font from

#https://github.com/FortAwesome/Font-Awesome/releases
# to refreh font cache
#sudo fc-cache -f -v




# setup font in applications
#sudo pacman -S lxappearance
## go to lxappearance, do any default font action, and .gtkrc-2.0 file will be generated
#Nano .gtkrc-2.0 # chyange gtk-font-name=”System San Francisco Display 13”
#Nano .config/gtk-3.0/settings.ini # gtk-font-name=System San Francisco Display
#https://github.com/bookercodes/setupi3/blob/master/config # for color settings
#sudo pacman -S thunar # basically file explorer
#https://github.com/horst3180/Arc-theme # windows theme
#sudo pacman -S arc-gtk-theme
## go to lxappearance and select Arc-Dark, apply


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

## wifi
#Ip link
#ip link set wlp3s0 up
#sudo pacman -S networkmanager
#sudo pacman -S network-manager-applet

# for desktop picture
sudo pacman -S feh
# terminal file manager
sudo pacman -S ranger



sudo pacman -Syu

#I3-msg exit # to logout

sudo pacman -S terminator

sudo pacman -S fish

sudo pacman -S htop

# reads various types of documents
# for mouseless, key bindings like vim, fast
# :print'
# + - resize
# night mode
# links like vimium
# configurable hotkeys and configuration
# bookmark like vim
sudo pacman -S zathura
sudo pacman -S zathura-pdf-poppler

# for documentations
sudo pacman -S groff

# customizable browser, easy hotkeys
# vimium like automatically
sudo pacman -S qutebrowser

# for printing stuff in qutebrowser
sudo pacman -S pdfjs

# needed for saving custom i3 layouts
sudo pacman -S perl-anyevent-i3


# thumbnail preview
# sxiv -ft */*.jpg
sudo pacman -S sxiv

# terminator alternative
sudo pacman -S tmux

# statistical computing and graphics
sudo pacman -S r

# terminal
# you can set instance name for easier configuration#
# used in i3 scratch windows
sudo pacman -S st

# for converting md to pdf
sudo pacman -S pandoc
sudo pacman -S texlive-most

sudo pacman -S xclip
sudo pacman -S xdotool

