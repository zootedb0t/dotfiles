#!/usr/bin/env bash

wal_dir=/home/stoney/Pictures/walls/

if [ -z "$1" ]; then
	wall="$(fd . "$wal_dir" -e jpg -e jpeg -e png --type f | shuf -n 1)"
else
	wall="$1"
fi

convert "$wall" ~/.local/share/bg.jpg
wal -c
wal -nqsi ~/.local/share/bg.jpg

if pgrep -x "dwm" >/dev/null; then
	xdotool key super+F5
fi

if pgrep -x "st" >/dev/null; then
	pidof st | xargs kill -s USR1
fi

# Generate zathura, dunst and rofi colorscheme
"$HOME"/.local/bin/pywalzathura &
"$HOME"/.local/bin/dunst_color.sh &
"$HOME"/.local/bin/pywalrofi &

xwallpaper --zoom ~/.local/share/bg.jpg && dunstify -i ~/.local/share/bg.jpg "Wallpaper Changed"
