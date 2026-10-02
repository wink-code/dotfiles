#!/usr/bin/env bash
set -euo pipefail

BAT=/sys/class/power_supply/BAT0

usage() {
  cat <<'EOF'
Usage: power.sh [command]

  status            Show current power profile and battery (default)
  cycle             Cycle performance -> balanced -> power-saver
  set <profile>     Set profile (performance|balanced|power-saver)
  <profile>         Shorthand for 'set <profile>'
  battery           Show battery status and capacity
EOF
}

notify() {
  command -v notify-send >/dev/null 2>&1 && notify-send -t 1500 -a Power "$1" "$2" || true
}

battery() {
  [ -r "$BAT/status" ] && echo "status: $(cat "$BAT/status")"
  [ -r "$BAT/capacity" ] && echo "capacity: $(cat "$BAT/capacity")"
}

set_profile() {
  local p="${1:-}"
  case "$p" in
    performance | balanced | power-saver) ;;
    s | save | saver | power-save | powersave) p=power-saver ;;
    perf | high) p=performance ;;
    bal | normal) p=balanced ;;
    *) echo "Unknown profile: '${p}'" >&2; exit 1 ;;
  esac
  powerprofilesctl set "$p"
  notify "Power profile" "$p"
  echo "$p"
}

cycle() {
  local cur next
  cur=$(powerprofilesctl get)
  case "$cur" in
    performance) next=balanced ;;
    balanced) next=power-saver ;;
    *) next=performance ;;
  esac
  set_profile "$next"
}

case "${1:-status}" in
  status)
    echo "profile: $(powerprofilesctl get)"
    battery
    ;;
  battery) battery ;;
  cycle) cycle ;;
  set) set_profile "${2:-}" ;;
  performance | balanced | power-saver) set_profile "$1" ;;
  -h | --help | help) usage ;;
  *)
    usage
    exit 1
    ;;
esac
