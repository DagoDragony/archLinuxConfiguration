#!/bin/bash

####################################
#
# Copies desired configuration from current user
#
####################################

foldersOutsideHomeDir=(
  "/etc/X11/xorg.conf.d"
)

foldersToCopyFromHomeDir=(
  ".config/i3"
  ".config/ranger"
  ".config/rofi"
  ".config/qutebrowser"
  ".vim"
  "bin"
)

for path in "${foldersOutsideHomeDir[@]}"
do
  destination=configuration/other$path
  mkdir -p $destination
  rsync --recursive $path/* $destination
done

for path in "${foldersToCopyFromHomeDir[@]}"
do
  destination=configuration/home/$path
  mkdir -p $destination
  rsync --recursive --no-links $HOME/$path/* $destination
done