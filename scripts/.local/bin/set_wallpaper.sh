#!/usr/bin/env bash

wal_dir=/home/stoney/Pictures/wallpapers

if [ -z "$1" ]; then
	wall="$(fd . "$wal_dir" -e jpg -e jpeg -e png --type f | shuf -n 1)"
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

# Generate zathura and dunst colorscheme 
"$HOME"/.local/bin/pywalzathura &
"$HOME"/.local/bin/dunst_color.sh &
