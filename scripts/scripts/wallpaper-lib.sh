#!/bin/bash
# Shared config and helpers for wallpaper-cycle.sh / wallpaper-restore.sh
#
# Runtime state must NOT live in the dotfiles repo: it changes on every
# wallpaper switch and would otherwise show up as a dirty git tree.
# It belongs in XDG_STATE_HOME (~/.local/state by default).

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/imgs/desktop}"
WALLPAPER_MONITOR="${WALLPAPER_MONITOR:-eDP-1}"
WALLPAPER_STATE="${WALLPAPER_STATE_FILE:-${XDG_STATE_HOME:-$HOME/.local/state}/hypr/wallpaper-index}"

# Sorted list of wallpapers.
# NOTE: the wallpaper dir is a symlink farm into dotfiles, so -L is required,
# otherwise `-type f` matches nothing.
wallpaper_list() {
    find -L "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | sort
}

# Current index, 0 when unset/garbage.
wallpaper_read_index() {
    local n
    n=$(cat -- "$WALLPAPER_STATE" 2>/dev/null)
    [[ $n =~ ^[0-9]+$ ]] || n=0
    printf '%s' "$n"
}

wallpaper_write_index() {
    mkdir -p -- "${WALLPAPER_STATE%/*}"
    printf '%s\n' "$1" >"$WALLPAPER_STATE"
}

wallpaper_apply() {
    hyprctl hyprpaper wallpaper "$WALLPAPER_MONITOR,$1"
}
