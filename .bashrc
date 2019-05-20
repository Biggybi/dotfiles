# ..~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# remap CAPSLOCK to CTRL in Mac OS
if [[ "$OSTYPE" == "darwin"* ]]
then
	hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'
fi

# vim as defaul editor
export VISUAL=vim
export EDITOR="$VISUAL"

# less : preserve colors
export LESS=-R

# autocd
# shopt -s autocd

stty -ixon						# C-s history navigation (with C-r), disable flow control
shopt -s cmdhist				# Combine multiline commands into one
shopt -s histappend				# append to the history file, don't overwrite
shopt -s histverify				# show hist cmd (from !) without executing
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="&:ls:bg:fg:exit"	# ignore some commands
HISTCONTROL=ignoreboth			# ignore dups and whitespace (= ignoredups:ignorespace)
# HISTCONTROL=ignorespace		# ignore commands starting with whitespace (private cmd)
# HISTCONTROL=ignoredups		# ignose duplicates

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#git autocomplete
source /usr/share/bash-completion/completions/git

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
	PS1="\[\e[01;30;47m\] \u\[\e[01;30;47m\] | \[\e[01;30;47m\]\h\[\e[01;30m\] \[\e[00;37m\] \w\[\e[00;37m\]\n> \[\e[0m\]"
	#red on grey
	#PS1="\[\e[01;31;47m\] \u\[\e[01;31;47m\] | \[\e[01;31;47m\]\h\[\e[01;31m\] \[\e[00;37m\] \w\[\e[00;37m\]> \[\e[0m\]"
	#blue on grey
	PS1="\[\e[01;34;47m\] \u\[\e[01;34;47m\] | \[\e[01;34;47m\]\h\[\e[01;34m\] \[\e[00;37m\] \w\[\e[00;37m\]\n> \[\e[0m\]"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# different prompt for ssh client
if [ -n "$SSH_CLIENT" ]
then
	PS1="\[\e[01;31;47m\] \u\[\e[01;31;47m\] | \[\e[01;31;47m\]\h\[\e[01;31m\] \[\e[00;37m\] \w\[\e[00;37m\]> \[\e[0m\]"
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
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
##alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

## Logo démarrage Terminal
##linuxlogo -L 27


## Mes alias

## hh -> better C-r
# add this configuration to ~/.bashrc
#export HH_CONFIG=hicolor         # get more colors
#shopt -s histappend              # append new history items to .bash_history
#export HISTCONTROL=ignorespace   # leading space hides commands from history
#export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
#export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
#if [[ $- =~ .*i.* ]]; then bind '"\C-r": "hh -- \C-j"'; fi

#ls mac colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export PATH=$PATH:~/.bin:/usr/lib
# export CDPATH=".:$HOME"
##source $HOME/.brewconfig.zsh

# Color man pages in `less`
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#better completion
bind 'set menu-complete-display-prefix on'
bind 'set mark-directories on'
bind 'set show-all-if-ambiguous on'

