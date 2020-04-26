###########################################################
#   ______  _____  ______  ______ __   __ ______  _____   #
#   |_____]   |   |  ____ |  ____   \_/   |_____]   |	  #
#   |_____] __|__ |_____| |_____|    |    |_____] __|__   #
#                                                 bashrc  #
###########################################################

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

# if [ -f ~/dotfiles/vim/bundle/fzf/shell/key-bindings.bash ]; then
# 	. ~/dotfiles/vim/bundle/fzf/shell/key-bindings.bash
# fi

# vi mode
set -o vi

# Environement variables
export PATH=$PATH:~/bin:/usr/lib:~/.npm-global/bin:/home/tris/go/bin:/home/linuxbrew/.linuxbrew/bin
export VISUAL=vim
export EDITOR="$VISUAL"
export BROWSER=firefox
export DOT="$HOME/dotfiles"
export HOM_VID="$HOME/Videos"
export HOM_PIC="$HOME/Pictures"
export HOM_GAM="$HOME/Games"
export HOM_DOC="$HOME/Documents"
export HOM_MUS="$HOME/Music"
export HOM_42="$HOME/42"
export GOPATH="$HOME/go"
export LFT="$HOM_42/libft/"
export DATAPATH="/media/data/"

# caps2escape
# if [[ -f $DOT/programs/caps2esc ]]
# then
# 	caps2esc
# fi

# Vim as pager
# export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#     vim -R -c 'set ft=man nomod nolist nonumber' -c 'map q :q<CR>' \
#     -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
#     -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

shopt -s checkwinsize				# auto adjust winsize after each command
#shopt -s globstar					# "**" match all files recursively
if [[ "$OSTYPE" != "darwin"* ]]
then
	shopt -s autocd					# autocd
fi


#better completion

bind 'TAB':menu-complete					# cycle through matches
bind 'set menu-complete-display-prefix on'	# partial completion, then cycle
bind 'set show-all-if-ambiguous on'			# show list of matching files
# bind 'set mark-directories on'

# programmable completion features, no need if
# in /etc/bash.bashrc sourced by /etc/profile
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
stty -ixon											# no term flow (C-q)
shopt -s cmdhist									# command one-liner
shopt -s histappend									# append to history
shopt -s histverify									# expand '!'
HISTSIZE= HISTFILESIZE=#							# infinite history
HISTIGNORE="&:ls:l:ll:cc:c:clear:bg:fg:exit:clear"	# ignored commands
HISTCONTROL=ignoreboth								# duplicate + whitespace
# HISTCONTROL=ignorespace							# whitespace
# HISTCONTROL=ignoredups							# duplicates

# man with vim
van ()
{
	if man "$1" > /dev/null 2>&1
	then
		vim -c "set ft=man nonu nornu | lcd" <(man $@);
	elif [ $# == 1 ]
	then
		echo "I don't have a man to $@"
	fi
}

# van() {
# 	echo $#
# 	echo $1
# 	if [ man "$1" > /dev/null 2>&1 ]
# 	then
# 		vim -c "set ft=man" <(man $@);
# 	elif [ $# -gt 0 ]
# 	then
# 		echo "I don't have a man to $@"
# 	else
# 		echo "Chose a van page"
# 	fi
# }

# fzf defaults
export FZF_DEFAULT_OPTS="-m"
export FZF_DEFAULT_OPTS+=" --color='light'"
export FZF_DEFAULT_OPTS+=" --height 40%"
export FZF_DEFAULT_OPTS+=" --bind 'ctrl-u:preview-up,ctrl-d:preview-down,ctrl-o:toggle+up,ctrl-i:toggle+down,ctrl-space:toggle-preview'"
# export FZF_DEFAULT_OPTS+=" --preview 'bat --style=numbers --color=always {} | head -500'"
export FZF_DEFAULT_OPTS+=" --preview 'head -500 {}'"
export FZF_DEFAULT_OPTS+=" --preview-window=:hidden"

# export FZF_DEFAULT_OPTS="--height 10"
# export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# # fzf history on C-r
# bind '"\C-r": "\C-x1\e^\er"';
# bind -x '"\C-x1": __fzf_history';

# # __fzf_history ()
# # {
# # 	__ehc $(history | fzf --color="light" --tac --tiebreak=index --height=10 | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"')
# # }

# # __ehc()
# # {
# # 	if
# # 		[[ -n $1 ]]
# # 	then
# # 		bind '"\er": redraw-current-line'
# # 		bind '"\e^": magic-space'
# # 		READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
# # 		READLINE_POINT=$(( READLINE_POINT + ${#1} ))
# # 	else
# # 		bind '"\er":'
# # 		bind '"\e^":'
# # 	fi
# # }

# # Another CTRL-R script to insert the selected command from history into the command line/region
# __fzf_history ()
# {
# 	builtin history -a;
# 	builtin history -c;
# 	builtin history -r;
# 	builtin typeset \
# 		READLINE_LINE_NEW="$(
# 			HISTTIMEFORMAT= builtin history |
# 			command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
# 			command sed '
# 				/^ *[0-9]/ {
# 					s/ *\([0-9]*\) .*/!\1/;
# 					b end;
# 				};
# 				d;
# 				: end
# 			'
# 		)";

# 		if
# 				[[ -n $READLINE_LINE_NEW ]]
# 		then
# 				builtin bind '"\er": redraw-current-line'
# 				builtin bind '"\e^": magic-space'
# 				READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
# 				READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
# 		else
# 				builtin bind '"\er":'
# 				builtin bind '"\e^":'
# 		fi
# }

# if [[ "$OSTYPE" != "darwin"* ]]
# then
# 	builtin set -o histexpand
# 	builtin bind '"\C-x": __fzf_history'
# 	builtin bind '"\C-r": "\C-x1\e^\er"'
# fi

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

git_branch()
{
	git symbolic-ref --short HEAD 2> /dev/null
}

# Prompt PS1
color_ps1()
{
	local START="\[\e[01;92m\]╭─"
	local USER="\[\e[01;93;100m\]  \u"
	local SEP="\[\e[01;37;100m\]  ⃒"
	local HOST="\[\e[01;92;100m\]\h"
	local DIR="\[\e[00;01;94m\]  \w"
	local BRANCH="\033[01;95m\]\$(git_branch %s)"
	local PROMPT="\n \[\e[0m\]"
	if [ -n "$SSH_CLIENT" ] ; then						# for ssh
		local SEP="\[\e[01;93;100m\]|"					# yellow sep
	fi
	if [ "$(id -u)" = 0 ] ; then						# for root
		# local SEP="\[\e[01;31;100m\]|"					# red sep
		local USER="\[\e[01;33;100m\]  \u"
	fi
	PS1="$START $USER $SEP $HOST  $DIR  $BRANCH $PROMPT"
}
# color_ps1

mkcd()
{
	if [ ! $1 ]
	then
		echo "usage: mkcd dir"
		return
	fi
	mkdir -p -- $1
	cd -P -- $1
}

# Title if xterm
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;\u   |   \h   \w\a\]$PS1"
		;;
	*)
		;;
esac
color_ps1

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

export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

[ -f $DOT/fzf.bash ] && source $DOT/fzf.bash
