#!/usr/bin/env bash

## Script to take screenshots with maim

time="$(date +%Y-%m-%d-%I-%M-%S)"
geometry="$(xrandr | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')"
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time}_${geometry}.png"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# Options for screenshots
shotnow=" Take Screenshot"
shotarea=" Take area screenshot"
shotwin=" Take current screenshot"
shot5="󰄉 Take screenshot in 5 sec"

# Choose option from dmenu
selected_option=$(
	echo "$shotnow
$shotarea
$shotwin
$shot5
" | dmenu -i -p "Choose one"
)

# notify
notify_user() {
	if [[ -e "$dir/$file" ]]; then
		dunstify -u low --replace=699 -i "$dir/$file" "Screenshot Saved" "$file"
	else
		dunstify -u low --replace=699 -i "$dir/$file" "Screenshot Deleted."
	fi
}

# countdown
countdown() {
	for sec in $(seq "$1" -1 1); do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow() {
	cd "${dir}" && sleep 1
	maim -u -f png "$file"
	notify_user
	# TODO clipboard not working
	# xclip -selection clipboard -t image/png -i "$file"
}

shotwin() {
	cd "${dir}" && maim -u -f png -i "$(xdotool getactivewindow)" "$file"
	notify_user
}

shotarea() {
	cd "${dir}" && maim -u -f png -s -b 2 -c 0.35,0.55,0.85,0.25 -l "$file"
	notify_user
}

shot5() {
	countdown '5'
	sleep 1 && cd "${dir}" && maim -u -f png "$file"
	notify_user
}

if [ "$selected_option" == "$shotnow" ]; then
	shotnow
elif [ "$selected_option" == "$shotarea" ]; then
	shotarea
elif [ "$selected_option" == "$shotwin" ]; then
	shotwin
elif [ "$selected_option" == "$shot5" ]; then
	shot5
else
	echo "No Match"
fi
