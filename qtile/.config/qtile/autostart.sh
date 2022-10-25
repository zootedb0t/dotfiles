#!/bin/sh

feh --bg-scale $HOME/Pictures/Wallpapers/girl.png
picom --config $HOME/.config/picom/picom.conf --experimental-backends --vsync & # --experimental-backends --vsync should prevent screen tearing on most setups if needed

# Low battery notifier
~/.config/qtile/scripts/check_battery.sh & disown

# Screen Locker
# ~/.config/qtile/scripts/locker.sh & disown
~/.local/bin/locker.sh & disown

# Start welcome
# eos-welcome & disown

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
