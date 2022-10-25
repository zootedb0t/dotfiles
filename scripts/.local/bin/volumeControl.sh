#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

function get_volume {
  amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  iconSound="/usr/share/icons/Adwaita/96x96/status/audio-volume-high-symbolic.symbolic.png"
  iconMuted="/usr/share/icons/Adwaita/96x96/status/audio-volume-muted-symbolic.symbolic.png"
  if is_mute ; then
    dunstify -i "$iconMuted" -r 2593 -u normal "mute"
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq --separator="─" 0 "$((volume / 5))" | sed 's/[0-9]//g')
    # Send the notification
    if [[ $volume == 0 ]]
    then
    dunstify -i  $iconMuted "$volume" -r 2593 -u normal "   $bar"
  else
    dunstify -i  $iconSound "$volume" -r 2593 -u normal "   $bar"
    fi
  fi
}

case $1 in
  up)
    # set the volume on (if it was muted)
    # amixer -D pulse set Master on > /dev/null
    # up the volume (+ 5%)
    # amixer -D pulse sset Master 3%+ > /dev/null
    # amixer -D pulse set Master 3%+ > /dev/null
    amixer -D pulse set Master 3%+
    send_notification
    ;;
  down)
    # amixer -D pulse set Master on > /dev/null
    # amixer -D pulse sset Master 3%- > /dev/null
    amixer -D pulse set Master 3%-
    send_notification
    ;;
  mute)
    # toggle mute
    amixer -D pulse set Master 1+ toggle
    send_notification
    ;;
esac
