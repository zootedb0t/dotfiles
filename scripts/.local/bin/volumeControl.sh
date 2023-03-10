#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

DIR="$HOME/.config/dunst"

function get_volume {
	amixer sget Master | grep 'Right:' | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'
	# wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F' ' '{print $2}' | awk -F'.' '{print $2}'
}

function send_notification {
	volume=$(get_volume)
	# bar=$(seq -s "─" 0 $((volume / 5)) | sed 's/[0-9]//g')
	if [ "$volume" -lt "10" ]; then
		icon_name="$DIR/icons/volume-10.svg"
	else
		if [ "$volume" -lt "30" ]; then
			icon_name="$DIR/icons/volume-10.svg"
		else
			if [ "$volume" -lt "70" ]; then
				icon_name="$DIR/icons/volume-30.svg"
			else
				icon_name="$DIR/icons/volume-70.svg"
			fi
		fi
	fi
	# fi
	# Send the notification
	dunstify "Volume $volume% " -i "$icon_name" -r 5555 -u normal -h int:value:$((volume))
	# dunstify "Volume $volume% " -r 5555 -u normal -h int:value:$((volume))
}

case $1 in
up)
	# Unmute
	# amixer -D pulse set Master on >/dev/null
	# amixer -q sset Master 3%+ >/dev/null
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1
	send_notification
	;;
down)
	# Unmute
	# amixer -D pulse set Master on >/dev/null
	# amixer -q sset Master 3%- >/dev/null
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1
	send_notification
	;;
mute)
	# Toggle mute
	# amixer -q sset Master toggle
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	is_mute="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F' ' '{print $3}' | awk -F'[][]' '{print $2}')"
	if [ "$is_mute" == "MUTED" ]; then
		icon_name="$DIR/icons/mute.svg"
		dunstify "Mute" -i "$icon_name" -r 5555 -u normal -h int:value:0
	else
		send_notification
	fi
	;;
esac
