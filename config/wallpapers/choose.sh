#!/bin/bash

HOUR=$(date +%H)

case "$HOUR" in
  00|01|02|03|04|05)
    WALLPAPER="/home/elbee/.config/wallpapers/night.png"
    ;;
  06|07|08|09|10|11)
    WALLPAPER="/home/elbee/.config/wallpapers/morning.png"
    ;;
  12|13|14|15|16|17)
    WALLPAPER="/home/elbee/.config/wallpapers/afternoon.png"
    ;;
  18|19|20|21|22|23)
    WALLPAPER="/home/elbee/.config/wallpapers/dark-sky.jpg"
    ;;
  *)
    WALLPAPER="/home/elbee/.config/wallpapers/dark-sky.jpg"
    ;;
esac

feh --bg-scale $WALLPAPER
betterlockscreen -u $WALLPAPER
