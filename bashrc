# ..~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# vi mode
set -o vi

# Environement variables
export PATH=$PATH:~/bin:/usr/lib
export VISUAL=vim
export EDITOR="$VISUAL"

shopt -s checkwinsize				# auto adjust winsize after each command
#shopt -s globstar					# "**" match all files recursively
shopt -s autocd					# autocd


#better completion

bind 'TAB':menu-complete					# cycle through matches
bind 'set menu-complete-display-prefix on'	# partial completion first, then cycle
bind 'set show-all-if-ambiguous on'			# show list of matching files
# bind 'set mark-directories on'

# programmable completion features, no need if in /etc/bash.bashrc sourced by /etc/profile
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

#git autocomplete
if [ -f /usr/share/bash-completion/completions/git ]; then
	. /usr/share/bash-completion/completions/git
fi

# history
stty -ixon							# C-s as rev C-r, disable term flow (C-s C-q)
shopt -s cmdhist					# Combine multiline commands into one
shopt -s histappend					# append to the history file, don't overwrite
shopt -s histverify					# show hist cmd (from !) without executing
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="&:ls:bg:fg:exit"		# ignore some commands
HISTCONTROL=ignoreboth				# ignore dups and whitespace (= ignoredups:ignorespace)
# HISTCONTROL=ignorespace			# ignore commands starting with whitespace (private cmd)
# HISTCONTROL=ignoredups			# ignose duplicates

# fzf history on C-r
bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

__fzf_history ()
{
	__ehc $(history | fzf --color="light" --tac --tiebreak=index --height=10 | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"')
}

__ehc()
{
	if
		[[ -n $1 ]]
	then
		bind '"\er": redraw-current-line'
		bind '"\e^": magic-space'
		READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
		READLINE_POINT=$(( READLINE_POINT + ${#1} ))
	else
		bind '"\er":'
		bind '"\e^":'
	fi
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export LESS=' -R '					# less preserve colors
# alias less='/usr/share/vim/vim81/macros/less.sh'	# vim less

# Color man pages in `less`
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

get_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' -e 's/(//;s/)//'
}

# Prompt PS1
color_ps1 () {
	local USER="\[\e[01;36;100m\]  \u"
	local SEP="\[\e[01;37;100m\]|"
	local HOST="\[\e[01;94;100m\]\h"
	local DIR="\[\e[00;01;91m\]  \w"
	local BRANCH="\033[01;92m\]\$(get_git_branch %s)"
# 	local BRANCH="\033[01;92m\]\$(__git_ps1 %s)"
	local PROMPT="\n \[\e[0m\]"
	if [ -n "$SSH_CLIENT" ] ; then						# for ssh
		local SEP="\[\e[01;93;100m\]|"					# yellow sep
	fi
	if [ "$(id -u)" = 0 ] ; then						# for root
		local SEP="\[\e[01;31;100m\]|"					# red sep
	fi
	PS1="$USER  $SEP  $HOST  $DIR  $BRANCH $PROMPT"
}
color_ps1

# Title if xterm
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;\u   |   \h   \w\a\]$PS1"
		;;
	*)
		;;
esac

## Terminal login banner message
# linuxlogo -L 27

if [[ "$OSTYPE" == "darwin"* ]]
then
	#ls mac colors
	export CDPATH=".:$HOME"
	source $HOME/.brewconfig.zsh
	export CLICOLOR='1'							# colors with tab (???) in Mac OS
	export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx		#ls colors for Mac OS
fi

# remap CAPSLOCK to CTRL in Mac OS
if [[ "$OSTYPE" == "darwin"* ]]
then
	hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'
fi
