#!/usr/bin/env bash

case $1 in
  normal)
    scrot '%H-%M-%S-screenshot.png' -e 'mv $f ~/Pictures/Screenshots/'; \
    dunstify "Screenshot Captured"
      ;;
  region)
    scrot -s '%H-%M-%S-region.png' -e 'mv $f ~/Pictures/Screenshots/'; \
    dunstify "Region Captured"
      ;;
esac
