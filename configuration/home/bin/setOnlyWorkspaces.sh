#!/usr/bin/bash

workspace1="1"
workspace2="2"
workspace3="3"
workspace4="4"
workspace5="5"
workspace6="6"
workspace7="7"
workspace8="8"
workspace9="9"


i3-msg workspace $workspace1, move workspace to output DP2-1 >/dev/null
i3-msg workspace $workspace2, move workspace to output DP2-2 >/dev/null
i3-msg workspace $workspace3, move workspace to output DP2-3 >/dev/null

sleep 1

i3-msg workspace $workspace4, move workspace to output DP2-1 >/dev/null
i3-msg workspace $workspace5, move workspace to output DP2-2 >/dev/null
i3-msg workspace $workspace6, move workspace to output DP2-3 >/dev/null

sleep 1

i3-msg workspace $workspace7, move workspace to output DP2-1 >/dev/null
i3-msg workspace $workspace8, move workspace to output DP2-2 >/dev/null
i3-msg workspace $workspace9, move workspace to output DP2-3 >/dev/null

