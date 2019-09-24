###########################################################
#   ______  _____  ______  ______ __   __ ______  _____   #
#   |_____]   |   |  ____ |  ____   \_/   |_____]   |	  #
#   |_____] __|__ |_____| |_____|    |    |_____] __|__   #
#												   zshrc  #
###########################################################

# history
# HISTSIZE= HISTFILESIZE= #			# infinite history

HISTSIZE=10000
SAVEHIST=10000
HISTIGNORE="&:ls:bg:fg:exit"		# ignore some commands
HISTCONTROL=ignoreboth				# duplicates and whitespace

# completion
autoload -U compinit
zstyle ':completion:*' menu selectzmodload zsh/complist
compinit
_comp_options+=(globdots)

zmodload zsh/complist

# vi mode
bindkey -v
export KEYTIMEOUT=1

# vi binds in tab completion menu
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^w' backward-kill-word
bindkey '^l' forward-word
bindkey '^h' backward-word
bindkey '^b' backward-char
bindkey '^f' forward-char
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^q' clear-screen
bindkey '^o' menu-complete-backward
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history
bindkey '^g' ' | grep '

# '^g^f": 'cd !$ \015'

# PS1
autoload -U colors && colors

git_branch() {
	git symbolic-ref --short HEAD 2> /dev/null
}

# PS1="%{$fg[yellow]%}%n %{$fg[green]%}┃ %{$fg[blue]%}%M %{$fg[magenta]%}%~ %{$fg[green]%}$(git_branch)%b %{$reset_color%}"$'\n'

# function zle-line-init zle-keymap-select {
#     case ${KEYMAP} in
#         # (vicmd)      PROMPT=$'%{\e[0;32m%}%~%{\e[0m%} %{\e[0;31m%}$%{\e[0m%} ' ;;
#         # (main|viins) PROMPT=$'%{\e[0;32m%}%~%{\e[0m%} $ ' ;;
#         # (*)          PROMPT=$'%{\e[0;32m%}%~%{\e[0m%} $ ' ;;
#         (vicmd)      PROMPT=$'%{\e[0;32m%}%~%{\e[0m%} %{\e[0;31m%}$%{\e[0m%} ' ;;
#         (main|viins) PROMPT=$'%{\e[0;32m%}%~%{\e[0m%} $ ' ;;
#         (*)          PROMPT=$'%{\e[0;32m%}%~%{\e[0m%} $ ' ;;
#     esac
#     zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select


color_ps1() {
	# local START="╭─%B"
	# local USER="%{$fg[yellow]$bg[white]%}%n"
	# local SEP="%{$fg[white]$bg[white]%}┃%{$fg[blue]$bg[white]%}"
	# local HOST="%{$fg[blue]$bg[white]%}%M"
	# local DIR="%{$fg[red]$bg[white]%}%~"
	# local BRANCH="%{$fg[green]$bg[white]%}%1v"
	# local END="%b%{$reset_color%}"
	# local END2="╰─ "


	local START="╭─%B"
	local USER="%{\e[0;36;100m%}""%n""%{\e[0m%}"
	# local USER="%{$fg[yellow]$bg[white]%}%n"
	local SEP="%{$fg[white]$bg[white]%}┃%{$fg[blue]$bg[white]%}"
	local HOST="%{$fg[blue]$bg[white]%}%M"
	local DIR="%{$fg[red]$bg[white]%}%~"
	local BRANCH="%{$fg[green]$bg[white]%}%1v"
	local END="%b%{$reset_color%}"
	local END2="╰─ "

	# if [ -n "$SSH_CLIENT" ] ; then						# for ssh
	# 	local SEP="\[\e[01;93;100m\]|"					# yellow sep
	# fi
	# if [ "$(id -u)" = 0 ] ; then						# for root
		# local SEP="\[\e[01;31;100m\]|"					# red sep
	# fi
	# return ("$START $USER  $SEP  $HOST  $DIR  $BRANCH $PROMPT")
	# eval "$1='$START' '$USER'  '$SEP'  '$HOST'  '$DIR'  '$BRANCH' '$PROMPT'"
	PS1="$START $USER  $SEP  $HOST  $DIR  $BRANCH$END"$'\n'$END2
	# eval "$1='$START $USER  $SEP  $HOST  $DIR  $BRANCH $PROMPT'"
    # zle reset-prompt
	echo "$PS1"
}
# color_ps1 PS1

setopt prompt_subst
# autoload -U promptinit
precmd() {
	psvar[1]=$(git_branch)
}

# PROMPT="%B╭─%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}] %{$fg[green]%}%1v%b %{$reset_color%}"$'\n'╰─
#  BRANCH="\033[01;92m\]\$(__git_ps1 %s)"
# PROMPT="\n \[\e[0m\]"

PROMPT=$'%B╭─ %{\e[01;36;100m%}  %n %{\e[0m%}%{\e[01;39;100m%}┃%{\e[0m%}%{\e[01;94;100m%} %M  %{\e[0m%} %{\e[00;01;91m%} %~%{\e[0m%} \033[01;92m%}%1v%{\e[0m% %{$reset_color%}'$'\n╰─ '

# echo $PS1

# aliases
if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

# distinguish insert mode
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
# function zle-line-init zle-keymap-select {
#     PS1_2="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     PS1="%{$terminfo_down_sc$PS1_2$terminfo[rc]%}%~ %# "
#     zle reset-prompt
# }
# preexec () { print -rn -- $terminfo[el]; }

# Color man pages in `less`
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
