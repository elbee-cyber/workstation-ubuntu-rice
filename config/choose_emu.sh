#!/bin/sh

if autorandr | head -n 1 | grep -q 'wide'; then
	/usr/bin/gnome-terminal
else
	/usr/bin/alacritty
fi
