#!/usr/bin/env bash

# Detect AC adapter
AC_PATH="/sys/class/power_supply/AC"
BAT_PATH="/sys/class/power_supply/ACAD"   # Some laptops use ACAD instead of AC

# Determine whether on AC power
if [ -d "$AC_PATH" ]; then
    STATUS_FILE="$AC_PATH/online"
elif [ -d "$BAT_PATH" ]; then
    STATUS_FILE="$BAT_PATH/online"
else
    STATUS_FILE=""
fi

on_ac=0
if [ -n "$STATUS_FILE" ] && [ "$(cat "$STATUS_FILE")" -eq 1 ]; then
    on_ac=1
fi

if [ "$1" = "open" ]; then
    hyprctl dispatch dpms on
    exit 0
fi

# Lid closed
if [ "$on_ac" -eq 1 ]; then
    hyprctl dispatch dpms off
    systemctl suspend
else
    hyprctl dispatch dpms off
    systemctl suspend-then-hibernate
fi

