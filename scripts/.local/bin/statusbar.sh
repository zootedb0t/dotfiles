#!/bin/sh

# Pending updates
get_updates()
{

    PREFIX='  Updates: '
    if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
        updates_arch=0
    fi

    if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
        updates_aur=0
    fi

    updates=$(("$updates_arch" + "$updates_aur"))

    echo "$PREFIX$updates"
}

get_ram() {

    PREFIX=' '
    TOTAL_RAM=$(free -mh --si | awk  {'print $2'} | head -n 2 | tail -1)
    USED_RAM=$(free -mh --si | awk  {'print $3'} | head -n 2 | tail -1)
    MB="MB"

    echo "$PREFIX$USED_RAM/$TOTAL_RAM"
}


get_cputemp()
{
  PREFIX=' '
  FIRE=' '
  WARNING_LEVEL=80

	CPU_T=$(cat /sys/class/thermal/thermal_zone0/subsystem/thermal_zone9/temp)
	CPU_TEMP=$(expr $CPU_T / 1000)

	# CPU_TEMP="$(sensors | grep temp1 | awk 'NR==1{gsub("+", " "); gsub("\\..", " "); print $2}')"

	if [ "$CPU_TEMP" -ge $WARNING_LEVEL ]; then
		PREFIX="$FIRE$PREFIX"
	fi

	echo "$PREFIX$CPU_TEMP°C"
}

volume_alsa() {

  muted=$(amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off | head -n 1)
  vol=$(amixer -D pulse get Master | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}')


	if [ "$muted" == "[off]" ]; then
		echo " muted"
	else
		if [ "$vol" -ge 65 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 40 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 0 ]; then
			echo " $vol%"	
		fi
	fi
}

# Prints out battery percentage
CHARGING_ICON=' '
WARNING_ICON=' '
BATTERY_FULL_ICON=''
BATTERY_2_ICON=''
BATTERY_3_ICON=''
BATTERY_4_ICON=''

FULL_AT=98

BAT_ICON=""
ICON=""

get_battery()
{
	# The vast majority of people only use one battery.

	if [ -d /sys/class/power_supply/BAT0 ]; then
		capacity=$(cat /sys/class/power_supply/BAT0/capacity)
		charging=$(cat /sys/class/power_supply/BAT0/status)
		if [[ "$charging" == "Charging" ]]; then
			ICON="$CHARGING_ICON"
		elif [[ $capacity -le 25 ]]; then
			ICON="$WARNING_ICON"
		fi

		if [[ $capacity -ge $FULL_AT ]]; then
			BAT_ICON=$BATTERY_FULL_ICON
		elif [[ $capacity -le 25 ]]; then
			BAT_ICON=$BATTERY_4_ICON
		elif [[ $capacity -le 60 ]]; then
			BAT_ICON=$BATTERY_3_ICON
		elif [[ $capacity -le $FULL_AT ]]; then
			BAT_ICON=$BATTERY_2_ICON
		fi
	fi
	echo "$ICON$BAT_ICON  $capacity%"
}

clock() {
	dte=$(date +"%D")
	time=$(date +"%H:%M")

	echo " $time  $dte"
}

main() {
	while true; do
		xsetroot -name " $(get_updates) | $(get_ram) | $(get_cputemp) | $(volume_alsa) | $(get_battery) | $(clock)"
		sleep 1
	done
}

main
