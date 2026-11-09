#!/bin/bash
# Usage: waybar.sh [reload]
# Keep exactly one waybar instance. Output hotplug and quick repeated presses
# used to race, leaving two bars on screen.

if [ "$1" = reload ] && pkill -USR1 -x waybar; then
    exit 0
fi

exec 9>"${XDG_RUNTIME_DIR:-/tmp}/waybar-restart.lock"
flock 9
pkill -x waybar
sleep 0.4
flock -u 9
exec waybar
