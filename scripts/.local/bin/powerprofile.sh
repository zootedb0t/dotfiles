#!/usr/bin/env bash

# Options for power profile
performance="  Performance"
balanced="盛  Balanced"
saver="  Saver"

active=$(powerprofilesctl get)

selected_option=$(echo "$performance
$balanced
$saver" | dmenu \
  -i \
  -p "Current profile - $active"\
)

if [ "$selected_option" == "$performance" ]; then
powerprofilesctl set performance
elif [ "$selected_option" == "$balanced" ]; then
 powerprofilesctl set balanced 
elif [ "$selected_option" == "$saver" ]; then
 powerprofilesctl set power-saver 
else
  echo "No match"
fi


send_notification() {
new_active=$(powerprofilesctl get)
if [ "$new_active" = 'power-saver' ]; then
icon_name="$HOME/.config/dunst/icons/saver.svg"
elif [ "$new_active" = 'balanced' ]; then
icon_name="$HOME/.config/dunst/icons/balanced.svg"
elif [ "$new_active" = 'performance' ]; then
icon_name="$HOME/.config/dunst/icons/performance.svg"
fi
dunstify "Power profile changed to" "$new_active " -i "$icon_name" -r 5555 -u normal
}

send_notification
