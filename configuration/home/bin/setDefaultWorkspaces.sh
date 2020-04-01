#!/usr/bin/bash

workspace1="1"
workspace2="2"
workspace3="3"

sleep 1

i3-msg workspace $workspace1, move workspace to output DP2-1 >/dev/null
nohup qutebrowser --target window --override-restore www.messenger.com >/dev/null 
nohup qutebrowser --target tab --override-restore https://calendar.google.com/calendar/r

sleep 1
i3-msg workspace $workspace2, move workspace to output DP2-2 >/dev/null
nohup qutebrowser --target window https://trello.com/b/OEHHMgp2/to-do-factory >/dev/null

sleep 1

i3-msg workspace $workspace3, move workspace to output DP2-3 >/dev/null
nohup qutebrowser --target window https://trello.com/b/33DloaNZ/it  >/dev/null
