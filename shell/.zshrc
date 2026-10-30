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

autoload -Uz compinit

# 自己的补全函数目录（如 _hyprctl），必须在 compinit 之前加进 fpath
fpath=("${ZDOTDIR:-$HOME}/.config/zsh/functions" $fpath)

# compinit 的缓存只比对「补全函数数量」和 zsh 版本。
# 软件包更新时如果删掉一个补全文件、又新增一个（数量不变），旧缓存就会被一直沿用，
# 于是报 "_hyprctl: function definition file not found" 这种错。
# 所以这里补一刀：任一 fpath 目录比缓存新，就删掉缓存让 compinit 重建。
_ZCOMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
for _zd in $fpath; do
    if [[ ! -f $_ZCOMPDUMP || $_zd -nt $_ZCOMPDUMP ]]; then
        rm -f -- "$_ZCOMPDUMP" "$_ZCOMPDUMP.zwc"
        break
    fi
done
unset _zd _ZCOMPDUMP

compinit
zmodload zsh/complist

zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# LS_COLORS 为空时 list-colors 也会被设成空，补全列表就没颜色了
[[ -z $LS_COLORS ]] && eval "$(dircolors -b)"
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

PROMPT=$'%F{cyan}%n@%m%f %F{blue}%1~%f ${vcs_info_msg_0_}\n%F{green}$%f '
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

function dict(){
    sdcv -n --utf8-output --color "$@" 2>&1 | \
        fold | \
        less --quit-if-one-screen -RX
}

function mkcd(){
    mkdir -p "$1" && cd "$1"
}


# ---------------------------------------------
# key-bind
# ---------------------------------------------
# Ctrl + left/right: jump word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Ctrl + Backspace: delete previous word group
bindkey '^[[W' backward-kill-word

# Shift+Tab: previous match
bindkey '^[[Z' reverse-menu-complete

export TERMINAL=kitty

# bun completions
[ -s "/home/johnwink/.bun/_bun" ] && source "/home/johnwink/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(direnv hook zsh)"

bindkey -v

