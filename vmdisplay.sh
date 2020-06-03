#!/bin/bash
#
# Author: DirWalk
# Date: June 3, 2020
#
# Bash script to adjust and correct the display resolution of stubborn VMs.

# Function for the default 1920x1080 and 60hz
function DEFAULT_RES(){
    NAME=$(cvt 1920 1080 60 | grep Modeline | cut -d' ' -f2)
    xrandr --newmode $NAME $(cvt 1920 1080 60 | grep Modeline | cut -d' ' -f3-) 2>/dev/null
    xrandr --addmode Virtual1 $NAME 2>/dev/null
    xrandr --output Virtual1 --mode $NAME 2>/dev/null
}

# Function for the custom resolution builder
function CUSTOM_RES(){
    read -p "What do you want your resolution to be? " RESOLUTION
            if [[ $RESOLUTION = *x* ]]; then
                    RESOLUTION=$(echo $RESOLUTION | sed 's/x/ /')
            fi
    read -p "What do you want your refresh rate to be? " REFRESH
            if [[ $REFRESH = *hz* || $REFRESH = *HZ* || $REFRESH = *Hz* || $REFRESH = *hZ* ]]; then
                    REFRESH=$(echo $REFRESH | sed 's/.\{2\}$//')
            fi
    NAME=$(cvt $RESOLUTION $REFRESH | grep Modeline | cut -d' ' -f2)
    xrandr --newmode $NAME $(cvt $RESOLUTION $REFRESH | grep Modeline | cut -d' ' -f3- ) 2>/dev/null
    xrandr --addmode Virtual1 $NAME 2>/dev/null
    xrandr --output Virtual1 --mode $NAME 2>/dev/null
}

# Main case statement
while true; do
    read -p "Do you want 1920x1080 with 60hz refresh rate? " DEFAULT
    case $DEFAULT in
        y|Y|Yes|yes|YES ) DEFAULT_RES;break;;
        n|N|No|no|NO ) CUSTOM_RES;break;;
        * ) echo "Please answer yes or no.";;
    esac
done
