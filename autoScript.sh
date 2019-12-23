#!/usr/bin/env bash

### MIRRORS!!!
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors /etc/pacman.d/mirrorlist > /etc/pacman.d/rankedmirrorlist
cp /etc/pacman.d/rankedmirrorlist /etc/pacman.d/mirrorlist

# Time
ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime

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

echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config

echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf

# Arch User Repository (AUR)
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf

# to file that is result of
cp /etc/i3blocks.conf ./

# gnome terminal fails without gdm
systemctl enable gdm.service
# enable internet on boot
systemctl enable dhcpcd
systemctl enable sshd.service
systemctl start sshd.service
systemctl enable tlp.service
systemctl enable tlp-sleep.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket