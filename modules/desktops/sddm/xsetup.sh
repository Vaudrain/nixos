#!/bin/sh
# Xsetup - run as root before the login dialog appears

xrandr --output HDMI-A-1 --off
xrandr --output DP-2 --off
xrandr --output DP-1 --mode 2560x1440 --pos 0x0 --rotate normal
