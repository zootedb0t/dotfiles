#!/usr/bin/env bash

## Script to take screenshots with maim

time="$(date +%Y-%m-%d-%I-%M-%S)"
geometry="$(xrandr | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')"
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time}_${geometry}.png"

# notify
notify_user () {
	if [[ -e "$dir/$file" ]]; then
		dunstify -u low --replace=699 -i "$dir/$file" "Screenshot Saved"
	else
		dunstify -u low --replace=699 -i "$dir/$file" "Screenshot Deleted."
	fi
}

# countdown
countdown () {
	for sec in $(seq "$1" -1 1); do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	cd "${dir}" && maim -u -f png "$file"
	notify_user
# TODO clipboard not working
# xclip -selection clipboard -t image/png "$dir/$file"
}

shot5 () {
	countdown '5'
	sleep 1 && cd "${dir}" && maim -u -f png "$file"
	notify_user
}

shot10 () {
	countdown '10'
	sleep 1 && cd "${dir}" && maim -u -f png "$file"
	notify_user
}

# shotwin () {
# 	cd ${dir} && maim -u -f png -i `xdotool getactivewindow` "$file"
# 	notify_user
# }

shotarea () {
	cd "${dir}" && maim -u -f png -s -b 2 -c 0.35,0.55,0.85,0.25 -l "$file"
	notify_user
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# if [[ "$1" == "--now" ]]; then
# 	shotnow
# elif [[ "$1" == "--in5" ]]; then
# 	shot5
# elif [[ "$1" == "--in10" ]]; then
# 	shot10
# elif [[ "$1" == "--win" ]]; then
# 	shotwin
# elif [[ "$1" == "--area" ]]; then
# 	shotarea
# else
# 	echo -e "Available Options : --now --in5 --in10 --win --area"
# fi

# Options for screenshots
shotnow=" Take Screenshot"
shotarea=" Take area screenshot"
timer_five="羽 Take screenshot in 5 sec"
timer_ten="福 Take screenshot in 10 sec"

# Choose option from rofi menu
selected_option=$( echo "$shotnow
$shotarea
$timer_five
$timer_ten
" | rofi -dmenu\
  -i\
  -p "Choose one"\
  -selected-row 0\
)

if [ "$selected_option" == "$shotnow" ]; then
  shotnow
elif [ "$selected_option" == "$shotarea" ]; then
  shotarea
elif [ "$selected_option" == "$timer_five" ]; then
  shot5
elif [ "$selected_option" == "$timer_ten" ]; then
  shot10
else
  echo "No Match"
fi

exit 0
