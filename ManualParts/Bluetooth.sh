#!/usr/bin/env bash

bluez
bluez-utils

systemctl start bluetooth
bluetoothctl power on
bluetoothctl


scan on
pair dev
connect dev

# modules stuff
lsmod # loaded kernel modules

# devices
lspci -k
lsusb


