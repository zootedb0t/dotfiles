#!/bin/sh

# Dependency xmenu, xclickroot. Shows a menu on right-click.
# Use tabs. If expandtab is set true, disable it in vim. Space between line gives separator.

xmenu <<EOF | sh &
󰲋 Applications
	󰖟  Browser
		IMG:$HOME/.config/xmenu/icons/firefox.svg							firefox 					firefox-nightly
		IMG:$HOME/.config/xmenu/icons/chrome.svg							Chrome 						chromium
	  Utilities
		IMG:$HOME/.config/xmenu/icons/file.svg							Files 	thunar
		IMG:$HOME/.config/xmenu/icons/st.png							Terminal 	st
		IMG:$HOME/.config/xmenu/icons/network.svg							Network Manager 	st -e nmtui
		IMG:$HOME/.config/xmenu/icons/Alacritty.svg						Alacritty 				alacritty
		IMG:$HOME/.config/xmenu/icons/zathura.svg							PDF Reader 				zathura
		IMG:$HOME/.config/xmenu/icons/protonvpn.svg						Proton VPN 				connectvpn.sh
		IMG:$HOME/.config/xmenu/icons/rss.svg				Newsboat 					st -e newsboat
		IMG:$HOME/.config/xmenu/icons/thunderbird.png					Thunderbird 			thunderbird
	 Code
		IMG:$HOME/.config/xmenu/icons/nvim.png							Neovim 						st -e nvim
		IMG:$HOME/.config/xmenu/icons/vs-code.svg							VS Code 					code
		IMG:$HOME/.config/xmenu/icons/Fleet.png							Fleet 						fleet
	 Music
		IMG:$HOME/.config/xmenu/icons/spotify.svg							Spotify 					spotify-launcher

 Config
	 Volume control 	pavucontrol
	 Edit dwm config 	st -e nvim ~/.local/src/suckless/dwm/config.def.h
	 Edit picom config 	st -e nvim ~/.config/picom/picom.conf
	 Edit st config 	st -e nvim ~/.local/src/suckless/orcst/config.def.h
	 Edit xmenu 	st -e nvim ~/.local/bin/menu.sh
	 Xresources 	st -e nvim $HOME/.Xresources

 Theming
	󰉦 Lxappearance 	lxappearance
	 Wallpapers 	wallpick

 Misc 
	Cava 	alacritty -e cava

 Monitor
	IMG:$HOME/.config/xmenu/icons/btop.svg						btop				st -e btop
	IMG:$HOME/.config/xmenu/icons/update.svg					Update System 			st -e sudo pacman -Syu	
󰚥 Power Options
	⏻ Power off 	systemctl poweroff
	 Reboot 	systemctl reboot
	󰍂 Log out 	loginctl terminate-user "$(whoami)"
EOF
