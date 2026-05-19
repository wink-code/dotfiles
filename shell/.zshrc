# ===================================================
# Arch Linux Zsh configure file
# ===================================================
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# ---------------------------------------------------
# basic config
# ---------------------------------------------------

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Share history
setopt SHARE_HISTORY

setopt HIST_IGNORE_DUPS

setopt HIST_REDUCE_BLANKS

# --------------------------------------------------
# auto completion
# --------------------------------------------------

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# -------------------------------------------------
# diretory goto
# -------------------------------------------------
alias ..='cd ..'

# -------------------------------------------------
# PROMPT
# -------------------------------------------------
autoload -Uz colors && colors

# Git info
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}%f'
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f %c%u'
zstyle ':vcs_info:git:*' actionformats '%F{green}(%b|%a)%f %c%u'

PROMPT=$'%F{cyan}%n@%m%f %F{blue}%1~%f ${vcs_info_msg_0_}\n%F{green}>%f '
RPROMPT='%F{240}%*%f'
setopt PROMPT_SUBST

# ------------------------------------------------
# environment variables
# ------------------------------------------------
# export LANG=zh_CN.UTF-8

export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/yay/src/yay-12.5.7/:$PATH"
export XKB_COMPOSE_DISABLE=1

# -----------------------------------------------
# ALIAS
# -----------------------------------------------

alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'

# opt security
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias c='clear'
alias h='history'
alias grep='grep --color=auto'

alias pacup='pacman -Syu'
alias pacin='pacman -S'
alias pacrm='pacman -Rns'

setopt EXTENDED_GLOB
LANG=en_US.UTF-8
export LANG


# ---------------------------------------------
# key-bind
# ---------------------------------------------
# Ctrl + left/right: jump word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Ctrl + Backspace: delete previous word group
bindkey '^[[W' backward-kill-word

# Tab: next match, Shift+Tab: previous match
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
bindkey '^I' menu-select
bindkey '^[[Z' reverse-menu-complete

export TERMINAL=kitty
