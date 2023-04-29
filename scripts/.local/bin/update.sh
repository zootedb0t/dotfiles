#!/bin/sh

st -t "System updates" -e bash -c "sudo pacman -Syu && echo \"Upgrade complete, press enter to exit.\" || echo \"Upgrade failed, press enter to exit.\"; read  -n 1 -p '' ignored;";
