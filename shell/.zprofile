
#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc
if [[ -f ~/.config/motd.sh ]]; then
    ~/.config/motd.sh
fi
