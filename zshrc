###########################################################
#   ______  _____  ______  ______ __   __ ______  _____   #
#   |_____]   |   |  ____ |  ____   \_/   |_____]   |	  #
#   |_____] __|__ |_____| |_____|    |    |_____] __|__   #
#												   zshrc  #
###########################################################

# aliases
if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

# Environement variables
export GOPATH=$HOME/bin/go
export PATH=$PATH:~/bin:/usr/lib:~/.npm-global/bin:/home/linuxbrew/.linuxbrew/bin
PATH+=:$GOPATH/bin
PATH+=:~/bin/norminette
export VISUAL=vim
export EDITOR="$VISUAL"
# export EDITOR="nvim"
export BROWSER=firefox
export DOT="$HOME/dotfiles"
export HOME_VID="$HOME/Videos"
export HOME_PIC="$HOME/Pictures"
export HOME_GAM="$HOME/Games"
export HOME_DOC="$HOME/Documents"
export HOME_MUS="$HOME/Music"
export HOME_42="$HOME/42"
export GOPATH="$HOME/go"
export LFT="$HOME_42/libft/"
export DATAPATH="/media/data/"

# disable shell scroll interrupt
stty -ixon

# history

export HISTFILE=~/.zsh_history
export SAVEHIST=1000000                 # 
export HISTSIZE=1000000                 # number of commands in session history
export HISTFILESIZE=1000000             # number of commands in history file
export HISTTIMEFORMAT="[%F %T] "
export HISTIGNORE="&:ls:bg:fg:exit"		# ignore some commands

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# completion
autoload -U compinit
zstyle ':completion:*' menu selectzmodload zsh/complist
compinit
_comp_options+=(globdots)

zmodload zsh/complist

# vi mode
bindkey -v
export KEYTIMEOUT=1

autoload edit-command-line
zle -N edit-command-line

# insert mode mappings
bindkey '^p' edit-command-line
bindkey '^b' backward-char
bindkey '^f' forward-char
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^l' clear-screen
bindkey '^j' vi-down-line-or-history
bindkey '^k' vi-up-line-or-history
bindkey '^o' expand-or-complete
bindkey '^n' accept-and-infer-next-history

# complete menu mode mappings
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^o' reverse-menu-complete

autoload -U colors && colors

__set_cursor() {
	local style
	case $1 in
		reset) style=0;; # The terminal emulator's default
		blink-block) style=1;;
		block) style=2;;
		blink-underline) style=3;;
		underline) style=4;;
		blink-vertical-line) style=5;;
		vertical-line) style=6;;
	esac
	[ $style -ge 0 ] && print -n -- "\e[${style} q"
}

# Set your desired cursors here...
__set_vi_mode_cursor() {
	case $KEYMAP in
		vicmd)
			__set_cursor block
			;;
		main|viins)
			__set_cursor vertical-line
			;;
	esac
}

__get_vi_mode_top() {
	local color
	case $KEYMAP in
		vicmd)
			color='%{\e[00;01;93m%}╭─%{\e[0m%}'
			;;
		main|viins)
			color='%{\e[00;01;92m%}╭─%{\e[0m%}'
			;;
	esac
	print -n -- $color
}

__get_vi_mode_bottom() {
	local color
	case $KEYMAP in
		vicmd)
			color='%{\e[00;01;93m%}╰─ 〈%{\e[0m%}'
			;;
		main|viins)
			color='%{\e[00;01;92m%}╰─ 〉%{\e[0m%}'
			;;
	esac
	print -n -- $color
}

DEFAULT_VI_MODE=viins

zle-keymap-select() {
# __set_vi_mode_cursor
zle reset-prompt
}

zle-line-init() {
zle -K $DEFAULT_VI_MODE
}

zle -N zle-line-init
zle -N zle-keymap-select


git_branch() {
	git symbolic-ref --short HEAD 2> /dev/null
}

setopt prompt_subst
# autoload -U promptinit
precmd() {
	psvar[1]=$(git_branch)
}

PROMPT=''
PROMPT+=$'$(__get_vi_mode_top) '
PROMPT+=$'%{\e[01;33;100m%}  %n %{\e[0m%}'  # User
PROMPT+=$'%{\e[01;39;100m%}  ⃒%{\e[0m%}'     # Sep
PROMPT+=$'%{\e[01;32;100m%} %M  %{\e[0m%} ' # Host
PROMPT+=$'%{\e[00;01;94m%} %~%{\e[0m%} '    # CWD
PROMPT+=$'%{\e[00;01;95m%}%1v%{\e[0m%} '    # Branch
PROMPT+=$'\n$(__get_vi_mode_bottom)'
PROMPT+=$'%{$reset_color%}'                               # End
# PROMPT=$'%B╭─ %{\e[01;36;100m%}  %n %{\e[0m%}%{\e[01;39;100m%}┃%{\e[0m%}%{\e[01;94;100m%} %M  %{\e[0m%} %{\e[00;01;91m%} %~%{\e[0m%} \033[01;92m%}%1v%{\e[0m% %{$reset_color%}'$'\n╰─ '

# rprompt

prompt_preexec() {
	prompt_preexec_ms=${(%):-%D{%s%3.}}
}

prompt_precmd() {
	if (( prompt_preexec_ms )); then
		local -ri now_ms=${(%):-%D{%s%3.}}
		local -ri elapsed_ms=$(( now_ms - prompt_preexec_ms ))
		local -ri elapsed_s=$(( elapsed_ms/1000 ))
		local -ri ms=$(( elapsed_ms%1000 ))
		local -ri s=$(( elapsed_s%60))
		local -ri m=$(( (elapsed_s/60)%60 ))
		local -ri h=$(( elapsed_s/3600 ))
		if (( h > 0 )); then
			prompt_elapsed_time=${h}h${m}m
		elif (( m > 0 )); then
			prompt_elapsed_time=${m}m${s}s
		elif (( s >= 10 )); then
			prompt_elapsed_time=${s}.${(l:2::0:)$(( ms/10 ))}s # 12.34s
		elif (( s > 0 )); then
			prompt_elapsed_time=${s}.${(l:3::0:)ms}s # 1.234s
		else
			prompt_elapsed_time=${ms}ms
		fi
		unset prompt_preexec_ms
	else
		# Clear previous result when hitting ENTER with no command to execute
		unset prompt_elapsed_time
	fi
}

setopt nopromptbang prompt{cr,percent,sp,subst}

autoload -Uz add-zsh-hook
add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

RPROMPT='%F{blue}${prompt_elapsed_time}%F{none}'


# Color man pages in `less`
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
	[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
	eval "$("$BASE16_SHELL/profile_helper.sh")"

# Load zsh-syntax-highlighting; should be last.
source ${HOME}/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${HOME}/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

# Fzf
[ -f $DOT/fzf.zsh ] && source $DOT/fzf.zsh
