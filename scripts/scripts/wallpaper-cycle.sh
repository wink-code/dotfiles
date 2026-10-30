#!/bin/bash
# Cycle through the wallpapers in $WALLPAPER_DIR using the hyprpaper IPC.

source "$(dirname "${BASH_SOURCE[0]}")/wallpaper-lib.sh"

mapfile -t WALLPAPERS < <(wallpaper_list)

# Safety check: empty wallpaper dir
if [ "${#WALLPAPERS[@]}" -eq 0 ]; then
    exit 1
fi

INDEX=$(( ($(wallpaper_read_index) + 1) % ${#WALLPAPERS[@]} ))
wallpaper_write_index "$INDEX"

wallpaper_apply "${WALLPAPERS[$INDEX]}"

FILENAME=$(basename "${WALLPAPERS[$INDEX]}")
#notify-send "Wallpaper changed" "$FILENAME" -i "$WALLPAPER_DIR/$FILENAME" 2>/dev/null || true
