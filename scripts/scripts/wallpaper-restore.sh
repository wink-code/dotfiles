#!/bin/bash

WALLPAPER_DIR="/home/johnwink/imgs/desktop"
STATE_FILE="/home/johnwink/.config/hypr/wallpaper-index"

for i in {1..20}; do
    if pgrep -x hyprpaper > /dev/null; then
        break
    fi
    sleep 0.5
done

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | sort)

if [ -f "$STATE_FILE" ]; then
  INDEX=$(cat "$STATE_FILE")
else
  INDEX=0
fi

[ "$INDEX" -ge "${#WALLPAPERS[@]}" ] && INDEX=0

hyprctl hyprpaper wallpaper "eDP-1,${WALLPAPERS[$INDEX]}"