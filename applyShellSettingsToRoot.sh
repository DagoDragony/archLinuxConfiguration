#!/bin/bash

####################################
#
# Applies desired configuration from current user
#
####################################

source envSettings.sh

saveDirInHomeDir="configuration/home"
foldersToCopyFromHomeDir=(
  ".config/zsh"
  ".config/aliasrc"
)

for path in "${foldersOutsideHomeDir[@]}"
do
  sync_files "$saveDirOutsideHomeDir$path" $path
done