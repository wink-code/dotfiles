# echo "PROFILE LOADED at $(date)" >> /tmp/profile_test.log
#if uwsm check may-start && uwsm select; then
#    exec uwsm start default
#fi

if uwsm check may-start; then
    exec uwsm start hyprland.desktop 
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

if [ -f ~/.config/hypr/env ]; then
	set -a
	source ~/.config/hypr/env
	set +a
fi

fastfetch
printf '\n'
