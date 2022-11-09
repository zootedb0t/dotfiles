#!/bin/sh

exec ~/.fehbg &

picom --config $HOME/.config/picom/picom.conf --experimental-backends --vsync & # --experimental-backends --vsync should prevent screen tearing on most setups if needed

# Low battery notifier
~/.config/qtile/scripts/check_battery.sh & disown

# Screen Locker
~/.local/bin/locker.sh & disown

sxhkd & # For keybindings

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
