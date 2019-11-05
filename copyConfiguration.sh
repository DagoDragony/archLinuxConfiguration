#!/bin/bash

####################################
#
# Copies desired configuration from current user
#
####################################

foldersOutsideHomeDir=(
  "/etc/X11/xorg.conf.d/10-monitor.conf"
)

foldersToCopyFromHomeDir=(
  ".fonts",
  ".config/i3/"
  ".config/ranger"
  ".config/rofi"
  ".config/qutebrowser"
  ".vim"
  "bin"
)

for path in "${foldersOutsideHomeDir[@]}"
do
  rsync --recursive $path configuration/other
done

for path in "${foldersToCopyFromHomeDir[@]}"
do
  rsync --recursive "$HOME/$path" configuration/home
done