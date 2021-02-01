#!/usr/bin/env bash



pacman -Syy

pacman -S --noconfirm neovim # just in case
# pacman -S grub-bios ???
#pacman -S wpa_supplicant wireless_tools

pacman -S --noconfirm reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector --country Lithuania -p http --sort delay --save /etc/pacman.d/mirrorlist

pacman -S --noconfirm linux-headers linux-lts linux-lts-headers
pacman -S --noconfirm grub

# set cryptodevice info
sed -i.bak 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="cryptdevice=\/dev\/sda3:cryptroot"/' /etc/default/grub

# add encrypt module
sed -i.bak 's/HOOKS=.*/HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck)/' /etc/mkinitcpio.conf

mkinitcpio -p linux-lts

grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# for internet to be available on next run
pacman -S --noconfirm dhcpcd
systemctl enable dhcpcd

# SETTINGS
echo "nameserver 1.1.1.1" >> /etc/resolvconf.conf

# change root password
[[ $(passwd --status root | awk '{print $2}') == 'P' ]] && passwd

pacman -S --noconfirm openssh
cat /etc/ssh/sshd_config | grep  "^PermitRootLogin"
if [[ $? == 1 ]]; then
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
else
  sed -i.bak 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/ssh_config
fi

systemctl start sshd

# create secondary user
id dago >/dev/null 2>&1
[[ $? == 0 ]] || useradd -m dago

[[ $(passwd --status dago | awk '{print $2}') == 'P' ]] && passwd dago

exit