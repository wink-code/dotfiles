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

# Last applied pool index, 0 when unset/garbage.
wallpaper_read_index() {
    local n
    n=$(cat -- "$WALLPAPER_STATE" 2>/dev/null)
    [[ $n =~ ^[0-9]+$ ]] || n=0
    printf '%s' "$n"
}

# Atomic write: a half-written state file would lose the position.
wallpaper_write_index() {
    local dir=${WALLPAPER_STATE%/*}
    [ "$dir" = "$WALLPAPER_STATE" ] || mkdir -p -- "$dir"
    printf '%s\n' "$1" >"$WALLPAPER_STATE.tmp" &&
        mv -f -- "$WALLPAPER_STATE.tmp" "$WALLPAPER_STATE"
}

# hyprpaper's IPC socket appears a moment after the process starts, so waiting
# for pgrep is not enough. Returns non-zero if it never comes up.
wallpaper_wait_ready() {
    local i
    for ((i = 0; i < ${1:-30}; i++)); do
        hyprctl hyprpaper listactive >/dev/null 2>&1 && return 0
        sleep 0.5
    done
    return 1
}

# Apply and verify. hyprpaper reports the resolved path, so compare real paths
# rather than the symlink paths from the wallpaper dir.
wallpaper_apply() {
    local path=$1 want got i
    want=$(realpath -e -- "$path" 2>/dev/null) || return 1
    wallpaper_wait_ready || return 1
    for i in 1 2 3; do
        hyprctl hyprpaper wallpaper "$WALLPAPER_MONITOR,$path" >/dev/null 2>&1 || {
            sleep 0.2
            continue
        }
        got=$(hyprctl hyprpaper listactive 2>/dev/null |
            awk -v m="$WALLPAPER_MONITOR:" '$1 == m { sub(/^[^:]*: /, ""); print; exit }')
        [ -n "$got" ] && [ "$(realpath -e -- "$got" 2>/dev/null)" = "$want" ] && return 0
        sleep 0.2
    done
    return 1
}
