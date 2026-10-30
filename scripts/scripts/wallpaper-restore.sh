#!/bin/bash
# Restore the last wallpaper picked by wallpaper-cycle.sh after login.

source "$(dirname "${BASH_SOURCE[0]}")/wallpaper-lib.sh"

# Wait for hyprpaper to come up (max 10s)
for i in {1..20}; do
    if pgrep -x hyprpaper >/dev/null; then
        break
    fi
    sleep 0.5
done

mapfile -t WALLPAPERS < <(wallpaper_list)

if [ "${#WALLPAPERS[@]}" -eq 0 ]; then
    exit 1
fi

INDEX=$(wallpaper_read_index)
[ "$INDEX" -ge "${#WALLPAPERS[@]}" ] && INDEX=0

wallpaper_apply "${WALLPAPERS[$INDEX]}"
