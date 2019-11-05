#!/usr/bin/bash

workspace1="I"
workspace2="II"
workspace3="III"

sleep 10

i3-msg workspace $workspace1, move workspace to output DP2-1
qutebrowser --target window --override-restore www.facebook.com
qutebrowser --target tab --override-restore www.youtube.com

sleep 1

i3-msg workspace $workspace2, move workspace to output DP2-2
qutebrowser --target window https://onedrive.live.com
sleep 1 

i3-msg workspace $workspace3, move workspace to output DP2-3
gnome-terminal
