#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

DIR="$HOME/.config/dunst"
BRIGHTNESS_STEPS=5

function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}

function send_notification {
  icon="$DIR/icons/brightness.svg"
  brightness=$(get_brightness)
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar=$(seq -s "─" 0 $((brightness / 5)) | sed 's/[0-9]//g')
  # Send the notification
  # dunstify -i "$icon" -r 5555 -u normal "    $bar"
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
