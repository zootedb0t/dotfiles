#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

DIR="$HOME/.config/dunst"

function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}

function send_notification {
  icon="$DIR/icons/brightness.svg"
  brightness=$(get_brightness)
  # Send the notification
  dunstify "Brightness $brightness%" -i "$icon" -r 5555 -u normal -h int:value:$((brightness))
}

case $1 in
  up)
    # increase the backlight by 5%
    xbacklight -inc 5
    send_notification
    ;;
  down)
    # decrease the backlight by 5%
    xbacklight -dec 5
    send_notification
    ;;
esac
