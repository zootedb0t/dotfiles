#!/bin/sh

case "$(printf " Connect\\n Disconnect\\n󱖫 Status" | dmenu -i -p "Choose one?")" in
  " Connect")
    st -e protonvpn-cli c &
  ;;
  " Disconnect")
    st -e protonvpn-cli d
  ;;
esac

