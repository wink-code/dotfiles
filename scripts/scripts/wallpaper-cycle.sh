#!/bin/bash
# Cycle through the wallpapers in $WALLPAPER_DIR using the hyprpaper IPC.

source "$(dirname "${BASH_SOURCE[0]}")/wallpaper-lib.sh"

mapfile -t WALLPAPERS < <(wallpaper_list)

# Safety check: empty wallpaper dir
if [ "${#WALLPAPERS[@]}" -eq 0 ]; then
    exit 1
fi

INDEX=$(( ($(wallpaper_read_index) + 1) % ${#WALLPAPERS[@]} ))

# Only remember the new position once hyprpaper actually shows it.
if wallpaper_apply "${WALLPAPERS[$INDEX]}"; then
    wallpaper_write_index "$INDEX"
else
    exit 1
fi
