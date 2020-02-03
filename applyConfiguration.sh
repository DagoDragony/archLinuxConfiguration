#!/bin/bash

####################################
#
# Applies desired configuration from current user
#
####################################

source envSettings.sh

for path in "${foldersOutsideHomeDir[@]}"
do
  sync_files "$saveDirOutsideHomeDir$path" $path
done

for path in "${foldersToCopyFromHomeDir[@]}"
do
  sync_files "$saveDirInHomeDir/$path" "$HOME/$path"
done