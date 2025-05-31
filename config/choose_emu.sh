#!/bin/sh

if cat ~/.config/monitor | grep -q 'wide'; then
	/usr/bin/gnome-terminal
else
	/usr/bin/alacritty
fi
