#!/usr/bin/bash

workspace1="1"
workspace2="2"
workspace3="3"

sleep 1

i3-msg workspace $workspace1, move workspace to output DP2-1 >/dev/null
nohup qutebrowser --target window --override-restore www.facebook.com>/dev/null 
nohup qutebrowser --target tab --override-restore www.youtube.com>/dev/null

sleep 1
i3-msg workspace $workspace2, move workspace to output DP2-2 >/dev/null
nohup qutebrowser --target window https://onedrive.live.com>/dev/null 

sleep 1

i3-msg workspace $workspace3, move workspace to output DP2-3 >/dev/null
nohup gnome-terminal>/dev/null 
