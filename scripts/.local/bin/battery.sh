#!/bin/sh

battery_perc="$(cat /sys/class/power_supply/BAT0/capacity)"

battery_notify() {
	if [ "$battery_perc" -lt 20 ]; then
		dunstify -t 2000 -u critical --replace=100 "Low Battry!!" "Please plugin"
	fi
}

while true; do
	battery_notify && sleep 600
done
