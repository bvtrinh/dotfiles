#!/bin/bash

xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off

# Fix the backgrounds
sh ~/.fehbg;

# Reload polybar
sh ~/.config/polybar/polybar-scripts/launch.sh
