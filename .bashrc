# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

function parse_git_dirty {
  [[ $(git status 2>/dev/null | grep -c "nothing to commit") != '1' ]] && echo '*'
}

function parse_git_branch {
  git branch --no-color 2>/dev/null | grep '^* ' | sed "s/* \(.*\)/[\1$(parse_git_dirty)]/g"
}

export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\] $(parse_git_branch)$ '

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias exe='chmod a+x'
alias sudo="sudo -E"
export EDITOR="vim"
export VISUAL="vim"

#alias ipython="ipython --no-confirm-exit --no-banner --quiet"
alias commit='git commit -a -m"misc"'
alias gdiff='git difftool'
alias st='git status'

LS_COLORS=$LS_COLORS:'tw=01;35:ow=01;35:'
export LS_COLORS

export PATH=~/scripts:$PATH
export LANG="C.UTF-8"
export DISPLAY=localhost:0.0
ulimit -c unlimited
export TMPDIR='/mnt/c/Users/petru/AppData/Local/Temp'
alias gdiff='git difftool -y --no-symlinks'

return 0

if ! service ssh status > /dev/null; then
    sudo service ssh start
fi

