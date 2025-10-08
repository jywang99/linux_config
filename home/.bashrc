# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# export TERM=xterm-256color
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

export XDG_CONFIG_HOME=$HOME/.config

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# shell config
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\n\[\e[01;33m\]\u@\h\[\e[0m\]\[\e[00;37m\] \t \[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[01;37m\] \[\e[0m\]\n$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

LS_COLORS="$C:di=0;36:ow=38;5;250;48;5;025:tw=38;5;250;48;5;025:st=38;5;252;48;5;017"
set -o vi

# Starship
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
# simple custom prompt
else
    PS1="\[\e[33m\]\u@\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]"
    PS1+="\[\e[90m\]{\`jobs | grep -E 'Running|Stopped' | wc -l\`}\[\e[m\]"
    PS1+="\\$ "
    export PS1
fi

# set vim as default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # nvm bash_completion

# zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

# WSL
if [[ $(grep -i Microsoft /proc/version) ]]; then
    # command prompt
    alias cmd.exe=/mnt/c/Windows/system32/cmd.exe

    # Windows directories
    windows_userprofile=$(cd /mnt/c/ && cmd.exe /c "echo %USERPROFILE%" | tr -d '\r')
    WIN_HOME=$(echo $windows_userprofile | sed 's|\\|/|g' | sed 's|C:|/mnt/c|')
    if [ -d "$WIN_HOME" ]; then
        export WIN_HOME
        export WIN_DL="$WIN_HOME/Downloads"
        alias cdd='cd $WIN_DL'
    fi

    # GUI apps
    export DISPLAY=$(ip route list default | awk '{print $3}'):0
    export LIBGL_ALWAYS_INDIRECT=1
fi

# aliases
alias tmux="tmux -u"
alias pu='pushd'
alias po='popd'
alias ta='tmux attach-session || tmux new-session'
alias watch='watch '

# Go
if command -v go &> /dev/null; then
    goBinPath=$(go env GOPATH)/bin
    export PATH=$PATH:$goBinPath
fi

# Python
PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export PYENV_ROOT
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# other user scripts (launched at bash start)
SCRIPTS_DIR="$XDG_CONFIG_HOME/launch"
if [ -d "$SCRIPTS_DIR" ]; then
    for f in $SCRIPTS_DIR/*; do
        . $f
    done
fi

# blesh
: "${BLESH:=/usr/share/blesh/ble.sh}"
if [[ -f $BLESH ]]; then
    [[ $- == *i* ]] && source $BLESH
    ble-bind -m vi_imap -f 'C-c' discard-line
    ble-bind -m vi_nmap -f 'C-c' discard-line
	ble-face auto_complete='fg=240,underline,italic'
fi

# fzf
: "${FZF_DIR:=/usr/share/fzf}"
if [ -d "$FZF_DIR" ]; then
    [ -f "$FZF_DIR/key-bindings.bash" ] && . "$FZF_DIR/key-bindings.bash"
    [ -f "$FZF_DIR/completion.bash" ] && . "$FZF_DIR/completion.bash"
fi

# completion
: "${BASH_COMPLETION_DIR:=$XDG_DATA_HOME/bash-completion/completions}"
if [ -d "$BASH_COMPLETION_DIR" ]; then
    [ -f "$BASH_COMPLETION_DIR/git" ] && . "$BASH_COMPLETION_DIR/git"
    [ -f "$BASH_COMPLETION_DIR/docker" ] && . "$BASH_COMPLETION_DIR/docker"
fi
# user-generated completion scirpts
USR_COMP_DIR="$XDG_CONFIG_HOME/bash-completion"
if [ -d "$USR_COMP_DIR" ]; then
    for f in $USR_COMP_DIR/*; do
        . $f
    done
fi

# User utilities
USER_BIN="$HOME/.local/bin"
if [ -d "$USER_BIN" ]; then
    export PATH=$PATH:$USER_BIN
fi

# keybindings
bind -x '"\ef": "cd && $(__fzf_cd__)"'
bind 'set keyseq-timeout 0'

. "$HOME/.cargo/env"
