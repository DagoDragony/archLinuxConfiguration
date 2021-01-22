#!/bin/sh

xrandr --listmonitors | grep DP2-1 > /dev/null
[[ $? -eq 1 ]] && xrandr --output DP2-1 --auto --pos 0x0

xrandr --listmonitors | grep DP2-2 > /dev/null
[[ $? -eq 1 ]] && xrandr --output DP2-2 --auto --pos 1920x0

xrandr --listmonitors | grep DP2-3 > /dev/null
[[ $? -eq 1 ]] && xrandr --output DP2-3 --auto --pos 3840x0

xrandr --output eDP1 --off \
	--output DP1 --off \
	--output DP2 --off \
	--output DP2-1 --mode 1920x1200 --pos 0x0 --rotate normal \
	--output DP2-2 --mode 1920x1200 --pos 1920x0 --rotate normal \
	--output DP2-3 --mode 1920x1200 --pos 3840x0 --rotate normal \
	--output HDMI1 --off \
	--output HDMI2 --off \
	--output VIRTUAL1 --off

i3 [workspace=1] move workspace to output DP2-1
i3 [workspace=2] move workspace to output DP2-2
i3 [workspace=3] move workspace to output DP2-3
