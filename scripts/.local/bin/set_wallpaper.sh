#!/usr/bin/env bash

wal_dir=/home/stoney/Pictures/wallpapers

if [ -z "$1" ]; then
	wall="$(find "$wal_dir" -type f -name "*.jpg" -o -name "*.png" | shuf -n1)"
else
	wall="$1"
fi

convert "$wall" ~/.local/share/bg.jpg
xwallpaper --zoom ~/.local/share/bg.jpg
wal -c
wal -i ~/.local/share/bg.jpg
if pgrep -x "dwm" >/dev/null; then
	xdotool key super+F5
fi
