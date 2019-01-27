#!/bin/bash

####################################
#
# Copies desired configuration from current user
#
####################################

foldersToCopyFromHomeDir=(
    ".fonts/."
    ".config/i3/."
    "bin/startup"
)

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/configuration"

for folderToCopy in "${foldersToCopyFromHomeDir[@]}"; do
    if [[ "${folderToCopy: -1}" == "."  ]]
    then
        destination="$scriptDir/${folderToCopy::-1}"
    else
        destination="$scriptDir/$folderToCopy"
    fi
    cp -rf ~/$folderToCopy $destination
done
