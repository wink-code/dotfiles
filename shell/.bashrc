#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PS1='[\e[37;1m\u\e[0m@\e[34;1m\h \e[34;4m\W\e[0m]$ '
stty -ixon
bind 'set horizontal-scroll-mode off'
