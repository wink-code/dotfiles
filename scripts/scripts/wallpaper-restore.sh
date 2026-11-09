#!/bin/bash
# Restore the last wallpaper picked by wallpaper-cycle.sh after login.

source "$(dirname "${BASH_SOURCE[0]}")/wallpaper-lib.sh"

mapfile -t WALLPAPERS < <(wallpaper_list)

if [ "${#WALLPAPERS[@]}" -eq 0 ]; then
    exit 1
fi

# The pool may have shrunk while the state still points past its end.
INDEX=$(( $(wallpaper_read_index) % ${#WALLPAPERS[@]} ))

if wallpaper_apply "${WALLPAPERS[$INDEX]}"; then
    wallpaper_write_index "$INDEX"
    exit 0
fi

# Saved wallpaper is gone or unusable: fall back to the first one.
wallpaper_apply "${WALLPAPERS[0]}" || exit 1
wallpaper_write_index 0
