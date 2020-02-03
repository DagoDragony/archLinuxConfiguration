#!/bin/bash

saveDirOutsideHomeDir="configuration/other"
foldersOutsideHomeDir=(
  "/etc/X11/xorg.conf.d"
)

saveDirInHomeDir="configuration/home"
foldersToCopyFromHomeDir=(
  ".config/i3"
  ".config/ranger"
  ".config/rofi"
  ".config/qutebrowser"
  ".config/nvim"
  "bin"
)

function sync_files {
  sourceDir=$1/*
  destinationDir=$2
  mkdir -p destinationDir
  echo "$sourceDir $destinationDir"
  rsync --recursive --no-links $sourceDir $destinationDir
}