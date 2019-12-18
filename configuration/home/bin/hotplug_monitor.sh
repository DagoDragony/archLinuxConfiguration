#!/usr/bin/bash

export XAUTHORITY=/home/dago/.Xauthority

function connect(){
    echo "connecting"
    # hack - only changing resolution all monitors wake up
    xrandr --verbose \
      --output eDP1 --off  \
      --output DP2-1 --off \
      --output DP2-2 --off \
      --output DP2-3 --off

   sleep 10

   xrandr --verbose \
      --output DP2-1 --mode 1920x1200 
	 
   xrandr --verbose \
      --output DP2-2 --mode 1920x1200
    
   xrandr --verbose \
      --output DP2-3 --auto

   sleep 10

   xrandr --verbose \
	--output DP2-1 --mode 1920x1200 --left-of DP2-2 \
	--output DP2-2 --mode 1920x1200 --left-of DP2-3 \
	--output DP2-3 --auto
   
   echo "connected"
}

function disconnect(){
    echo "disconnecting"
    xrandr --output eDP1 --primary --mode 1600x900
    echo "disconnected"
}


xrandr | grep "DP2-1 connected" &> /dev/null && connect || disconnect
