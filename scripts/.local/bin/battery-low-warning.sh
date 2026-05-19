#!/usr/bin/env bash
# Get battery percentage (0‑100)
PERCENT=$(upower -i $(upower -e | grep BAT) | grep -E "percentage" | awk '{print $2}' | tr -d '%')
# Only act if on battery and below threshold
if [[ "$PERCENT" -le 10 ]]; then
    # Optional: avoid spamming – send at most once every 5 minutes
    LAST=$(cat /tmp/battery-low-last 2>/dev/null || echo 0)
    NOW=$(date +%s)
    if (( NOW - LAST > 300 )); then
        notify-send -u critical "Battery Low" "Battery is at ${PERCENT}% – plug in charger!"
        echo $NOW > /tmp/battery-low-last
    fi
fi
