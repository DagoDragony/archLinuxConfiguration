#!/usr/bin/env bash

source ./Installers/InstallYay.sh

### MIRRORS!!!
#pacman -S pacman-contrib # contains rankmirrors app
#cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
#rankmirrors /etc/pacman.d/mirrorlist > /etc/pacman.d/rankedmirrorlist
#cp /etc/pacman.d/rankedmirrorlist /etc/pacman.d/mirrorlist

mkdir -p $HOME/{Projects,Installs} $HOME/Documents/remoteShare/

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

# to file that is result of
cp /etc/i3blocks.conf ./

# gnome terminal fails without gdm
#systemctl enable gdm.service # for some reasons it didn't work on new installation
systemctl enable sddm
# enable internet on boot
systemctl enable dhcpcd
systemctl enable sshd.service
systemctl start sshd.service
systemctl enable tlp.service
systemctl enable tlp-sleep.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket

systemctl enable tlp
# SSD optimization to t
sudo systemctl enable fstrim.timer;
sudo systemctl start fstrim.timer
# vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~/Installs
git clone https://github.com/LukeSmithxyz/st.git && cd st; make
sudo ln -s -t /usr/bin ~/Installs/st/st


sudo ln -s -t /usr/local/bin ~/.config/scripts/tools/transadd

# fix for st not crashing when rendering smileys and similar symbols
yay libxft-bgra

tempFolderName=$(uuidgen -t)
mkdir -p /tmp/$tempFolderName && cd /tmp/$tempFolderName
echo $tempFolderName
intellijLink="https://download.jetbrains.com/idea/ideaIC-2019.3.4.tar.gz"
curl -LfO $intellijLink
intellijArchive=$(find . -type f -print -quit)
tar -xf $intellijArchive
intellijDir=$(find . -type d -name \*idea\* -print -quit)
cp -r $intellijDir ~/Installs
sudo ln -s -t /usr/local/bin ~/Installs/$intellijDir/bin/idea.sh
# todo scala plugin

chsh -s /bin/zsh

chsh -S /bin/zsh

# vim-instant-markdown needs
sudo npm -g install instant-markdown-d
sudo npm -g install instant-markdown-d@next

sudo pacman -S xdg-utils
sudo pacman -S nodejs

sudo systemctl enable cronie
/sbin/hwclock --systohc # coud be  added to cron.daily

systemctl start logwatch.timer
systemctl enable logwatch.timer

rkhunter --propupd

systemctl start sendmail
systemctl enable sendmail

systemctl start atd
systemctl enable atd

systemctl enable sysstat # for sar stats collecting
systemctl start  sysstat

# docker configuration
# dockd --config docked # captures docked configuration and saves it’s
# dockd --config undocked # saves undocked configuration
# for dockd
systemctl enable acpid
systemctl start acpid


