#!/usr/bin/env bash

keepassxc &

swww init &

swww img ~/.config/bg.jpg &

nm-applet --indicator &

waybar &

xwaylandvideobridge &
