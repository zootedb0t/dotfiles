#!/bin/sh

# exec xautolock -detectsleep -time 3 -locker "betterlockscreen -l dim" \
#   -notify 30 \
#   -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'";

# Dim screen not working

exec xset dpms 0 0 120 &
# exec xset s 60 120 &
# exec xss-lock -- i3lock -e -k -i /home/stoney/Pictures/Wallpapers/samurai.png &
exec xss-lock -- ~/.local/bin/blur.sh &
