sudo pacman -S networkmanager network-manager-applet network-manager-sstp
ip link

sudo systemctl disable dhcpcd@enp0s31f6
sudo systemctl disable netctl-auto@wlp1s0.service
sudo systemctl enable NetworkManager.service

reboot

nm-applet
nm-connection-editor
nmcli
nmtui

wify
wify  device/driver?
sudo lspci -kv
lsusb -v
modprobe - add or remove modules from the linux Kernel
udev scripts /etc/udev/
udevadm
linux-firmware
/etc/netctl/ - place of network profiles(including  generated by wifi-menu)
nmcli device
nmcli device wifi
nmcli device wifi list
nmcli radio wifi off
nmcli connection down id Hive
# do I need netctl