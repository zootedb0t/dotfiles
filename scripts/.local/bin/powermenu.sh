#!/bin/env bash

# Options for powermenu
lock="    Lock"
logout="    Logout"
shutdown="    Shutdown"
reboot="    Reboot"
sleep="    Sleep"

uptime="$(uptime -p | sed -e 's/up //g')"
user="$(whoami)"

# Get answer from user via rofi
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu \
		-p "$user" \
		-mesg "Uptime: $uptime" \
    -theme "$HOME/.config/rofi/powermenu.rasi"\
)

# Do something based on selected option
if [ "$selected_option" == "$lock" ]
then
    /home/stoney/.local/bin/blur.sh
elif [ "$selected_option" == "$logout" ]
then
    loginctl terminate-user "$user"
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
    systemctl suspend
else
    echo "No match"
fi

