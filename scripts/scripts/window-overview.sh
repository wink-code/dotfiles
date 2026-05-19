#!/bin/bash
# Window overview - opens a kitty window with a numbered list of windows

# Generate the list
LIST=$(hyprctl clients -j | python3 -c "
import sys, json, subprocess

clients = json.load(sys.stdin)
monitors = json.loads(subprocess.check_output(['hyprctl', 'monitors', '-j']))
current_ws = None
for m in monitors:
    if m.get('focused'):
        current_ws = m['activeWorkspace']['id']
        break

if current_ws is None:
    sys.exit(1)

i = 1
for c in clients:
    if c['workspace']['id'] == current_ws:
        title = c['title'] or '(untitled)'
        floating = ' [F]' if c.get('floating') else ''
        print(f'{i}. {title}{floating}')
        i += 1
")

if [ -z "$LIST" ]; then
    notify-send "Window Overview" "No windows on current workspace"
    exit 0
fi

# Open kitty with the menu
kitty --title "Window Overview" -e bash -c "
clear
echo '================================'
echo '     Window Overview'
echo '================================'
echo ''
echo '$LIST' | sed 's/^/  /'
echo ''
echo '================================'
read -p '  Enter number to switch (or Enter to cancel): ' NUM

if [ -n \"\$NUM\" ] && [ \"\$NUM\" -eq \"\$NUM\" ] 2>/dev/null; then
    ADDR=\$(hyprctl clients -j | python3 -c \"
import sys, json, subprocess
clients = json.load(sys.stdin)
monitors = json.loads(subprocess.check_output(['hyprctl', 'monitors', '-j']))
current_ws = None
for m in monitors:
    if m.get('focused'):
        current_ws = m['activeWorkspace']['id']
        break
if current_ws is None:
    sys.exit(1)
i = 1
for c in clients:
    if c['workspace']['id'] == current_ws:
        if i == $NUM:
            print(c['address'])
            break
        i += 1
\")
    if [ -n \"\$ADDR\" ]; then
        hyprctl dispatch focuswindow address:\$ADDR
    fi
fi
"
