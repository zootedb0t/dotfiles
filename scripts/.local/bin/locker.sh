#!/bin/sh

# exec xautolock -detectsleep -time 1 -locker "betterlockscreen -l dim" \
#   -notify 30 \
#   -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'";

xset dpms 180 &
# xss-lock -- i3lock -e -k -i /home/stoney/Pictures/Wallpapers/samurai.png &
xss-lock -- ~/.local/bin/blur.sh
