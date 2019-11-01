#!/usr/bin/env python3

####################################
#
# Copies desired configuration from current user
#
####################################

import shutil
import os
import errno
import disutils



foldersToCopyFromHomeDir=[
#    "/etc/X11/xorg.conf.d/10-monitor.conf"
    "/home/dago/.fonts/",
    "~/.config/i3"
#    "~/.config/ranger/."
#    "~/.config/rofi/."
#    "~/.config/qutebrowser/."
#    "~/.vim/."
#    "~/bin/startup"
#    "~/bin/hotplug_monitor.sh"
#    "~/bin/setDefaultWorkspaces.sh"
]

def copy(src, dest):
    try:
        shutil.copytree(src, dest)
    except OSError as e:
        # If the error was caused because the source wasn't a directory
        if e.errno == errno.ENOTDIR:
            shutil.copy(src, dest)
        else:
            print('Directory not copied. Error: %s' % e)

scriptDir=os.path.dirname(os.path.realpath(__file__))+"/configuration/"

for folderToCopy in foldersToCopyFromHomeDir:
    copy(folderToCopy, scriptDir)
    print(folderToCopy)

# for folderToCopy in "${foldersToCopyFromHomeDir[@]}"; do
#     if [[ $folderToCopy == "~/*" ]]
#         folderToCopy=
#
#     if [[ "${folderToCopy: -1}" == "."  ]]
#     then
#         destination="$scriptDir/${folderToCopy::-1}"
#     else
#         destination="$scriptDir/$folderToCopy"
#     fi
#
#     echo $folderToCopy $destination
#     cp -rf $folderToCopy $destination
# done
