#!/bin/bash

####################################
#
# Copies desired configuration from current user
#
####################################

source envSettings.sh

for path in "${foldersOutsideHomeDir[@]}"
do
  sync_files $path "$saveDirOutsideHomeDir$path"
done

for path in "${foldersToCopyFromHomeDir[@]}"
do
  sync_files "$HOME/$path" "$saveDirInHomeDir/$path"
done


