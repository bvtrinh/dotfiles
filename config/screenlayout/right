#!/bin/bash


# Only works for one monitor
# Get the current monitor plugged in that isn't the primary one
monitor=`xrandr | grep -w "connected" | grep -v primary | awk '{print $1;}'`;

# Turn of the monitor and display
xrandr --output $monitor --right-of eDP-1 --auto;

# Fix the backgrounds
sh ~/.fehbg;

# Reload polybar
sh ~/.config/polybar/polybar-scripts/launch.sh
