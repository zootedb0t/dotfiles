#!/bin/sh

# set the icon and a temporary location for the screenshot to be stored
# How to make icon random
icon="$HOME/Pictures/Wallpapers/lock.png"
tmpbg='/tmp/lock.png'

# take a screenshot
scrot "$tmpbg"

# blur the screenshot by resizing and scaling back up
convert "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"

# overlay the icon onto the screenshot
convert "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# lock the screen with the blurred screenshot
# i3lock -n -i "$tmpbg"
slock &
