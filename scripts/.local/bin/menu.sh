#!/bin/sh

# Dependency xmenu, xclickroot. Shows a menu on right-click.
# Use tabs. If expandtab is set true, disable it in vim. Space between line gives separator.

cat <<EOF | xmenu | sh &
󰆧 Launch Dmenu 	dmenu_run
 Launch Terminal	st

󱐋 Applications
	󰖟  Browser
		 Firefox 	firefox-nightly
		 Chromium 	chromium
	  Utilities
		 Files	thunar
		 Pdf Reader 	zathura
		 Proton Vpn 	protonvpn
	󰇰 Thunderbird 	thunderbird

 RSS Feed 	st -e newsboat

 Config
	󰆧 System
		 Volume control 	pavucontrol
		 Edit dwm config 	st -e nvim ~/.local/src/suckless/dwm/config.def.h
		 Edit picom config 	st -e nvim ~/.config/picom/picom.conf
		 Edit st config 	st -e nvim ~/.local/src/suckless/orcst/config.def.h
		 Edit menu 	st -e nvim ~/.local/bin/menu.sh
		 Xresources 	st -e nvim $HOME/.Xresources
	󰲋 Application
		 Newsboat 	st -e nvim ~/.config/newsboat/config
		 Nvim 	st -e nvim ~/.config/nvim/init.lua
		󰎟 Dunst 	st -e nvim ~/.cache/wal/dunstrc

 Theming
	󰉦 Lxappearance 	lxappearance
	 Wallpapers 	st -e nsxiv ~/Pictures/wallpapers/

 Misc 
	Colors Script
		Cbonsai 	st -e cbonsai
	Cava 	st -e cava

 Monitor
	󱜙 Btop 	st -e btop
	 Update System 	st -e sudo pacman -Syu

⏻ Power off 	systemctl poweroff
 Reboot 	systemctl reboot
󰍂 Log out 	loginctl terminate-user "$(whoami)"
EOF
