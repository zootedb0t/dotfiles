#!/bin/sh

movie_dir=/home/stoney/Videos/Movies/

list="$(fd . "$movie_dir" -e mp4 -e mkv --type f | dmenu -i -l 12)"

mpv "$list"
