#!/bin/bash

####################################
#
# Copies desired configuration from current user
#
####################################

foldersToCopyFromHomeDir=(
#    ".fonts/."
    ".config/i3/config"
    "bin/startup"
)

# cp -r "~/.fonts/." "configuration/.fonts/"


scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/configuration"

for folderToCopy in "${foldersToCopyFromHomeDir[@]}"; do
    if [[ "${folderToCopy: -1}" == "."  ]]
    then
        destination="$scriptDir/${folderToCopy::-1}"
    else
        destination="$scriptDir/$folderToCopy"
    fi
    #echo "~/$folderToCopy $destination"
    cp -rf ~/$folderToCopy $destination
done

#cp -r ~/.fonts/. configuration/.fonts/
#cp -r ~/.config/i3/config configuration/.config/i3/
#cp -r ~/bin/startup configuration/bin/startup
