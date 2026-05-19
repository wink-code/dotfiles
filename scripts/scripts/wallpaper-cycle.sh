#!/bin/bash
# Cycle through wallpapers using hyprpaper IPC

WALLPAPER_DIR="/home/johnwink/imgs/desktop"
STATE_FILE="/home/johnwink/.config/hypr/wallpaper-index"

# Get list of wallpapers (sorted)
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | sort)

# Read current index
if [ -f "$STATE_FILE" ]; then
  INDEX=$(cat "$STATE_FILE")
else
  INDEX=0
fi

# Advance to next
INDEX=$(((INDEX + 1) % ${#WALLPAPERS[@]}))
echo "$INDEX" >"$STATE_FILE"

# Apply wallpaper
hyprctl hyprpaper wallpaper "eDP-1,${WALLPAPERS[$INDEX]}"

# Show notification
FILENAME=$(basename "${WALLPAPERS[$INDEX]}")
#notify-send "Wallpaper changed" "$FILENAME" -i "$WALLPAPER_DIR/$FILENAME" 2>/dev/null || true