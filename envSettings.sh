#!/bin/bash

saveDirOutsideHomeDir="configuration/other"
foldersOutsideHomeDir=(
  "/etc/X11/xorg.conf.d"
  "/etc/zsh/zshenv"
  "/var/spool/cron"
)

saveDirInHomeDir="configuration/home"
foldersToCopyFromHomeDir=(
  ".config/i3"
  ".config/i3blocks"
  ".config/ranger"
  ".config/rofi"
  ".config/qutebrowser"
  ".config/nvim"
  "bin"
  ".local/share/applications/torrent.desktop"
  ".config/mimeapps.list"
  ".config/transmission-daemon/settings.json"
  ".config/scripts"
  ".config/zsh"
  ".config/aliasrc"
)

function sync_files {
  source=$1
  destination=$2
  mkdir -p $(dirname $destination)
  if [[ -f $source ]]; then
    cp $source $destination
  elif [[ -d $source ]]; then
    rsync --recursive --no-links $source/ $destination
  else
    notify-send "Warning" "Path \"$source\" not found!"
  fi
}