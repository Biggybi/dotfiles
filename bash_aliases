# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    bash_aliases                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tris <tristan.kapous@protonmail.com>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/23 19:49:29 by tris              #+#    #+#              #
#    Updated: 2020/04/13 04:31:35 by tris             ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

ALIAS_42_HOME=$HOME/42
ALIAS_42_LFT=$HOME/42/libft

shopt -s expand_aliases

alias s='sudo'
alias c='clear'

#vi debug: no vimrc/gvimrc, nocompatible
alias vimnude='vim -u NONE -U NONE -N'

## color
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

## ls
if [[ "$OSTYPE" == "darwin"* ]]
then
	alias ls='ls -h'
fi

if [[ -x "$(command -v exa)" ]]
then
	alias ls='exa'
	alias l='ls -F'
	alias ll='ls -l'
	alias la='ls -la'
else
	## ls
	alias ls='ls -h --group-directories-first --color=auto'
	alias ll='ls -trhalF'
	alias la='ls -lA'
	alias l='ls -CF'
	alias lsd='find . -maxdepth 1 -type f -name ".*" -exec basename {} \;'

fi

## cp is rsync
alias cp='rsync -vh --archive --progress --whole-file'

## Git

alias g='git'
alias gd='git diff'
alias gurl='git config --get remote.origin.url'
alias gg='cd $(git rev-parse --show-toplevel)' #go to the root of a git repo
alias gitroot='cd $(git rev-parse --show-toplevel)' #go to the root of a git repo
alias groot='cd $(git rev-parse --show-toplevel)' #go to the root of a git repo
alias gcd='cd $(git rev-parse --show-toplevel)' #go to the root of a git repo
alias gdiff='git diff-files -z --diff-filter=M --name-only --relative | xargs -0 git add'
alias gits='git status '
alias ga='git add '
alias gau='git add -u '
alias gam='git commit -am '
alias gcl='git clone '
alias grm='git rm --cached '
alias grmf='git rm -f '
alias gps='git push '
alias gpl='git pull '
alias gcm='git commit -m '
alias gita='git add '
alias gco='git checkout '
alias gcb='git checkout -b '
alias graph='git log --all --decorate --oneline --graph'
alias gch='git log | grep -B 4 "$*" | head -n 1 | cut -d\  -f 2'
alias gb='git branch '
alias gba='git branch -a'
alias gbr='git branch -r'
alias gitls='git ls-tree --full-tree -r --name-only HEAD'
alias gown='sudo chown -R "${USER:-$(id -un)}" .'

## grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias le='less'
alias ccat='highlight --out-format=ansi'

alias r='ranger'

## df
alias df='df -h'

## free
alias free='free -h'

## vim
alias e="$EDITOR"
alias v="vim"
alias vi='vim'
alias sv="sudo vim"

## mutt
alias mutt="neomutt"
alias m="neomutt"

### ssh
alias sshhome='ssh biggybi@192.168.1.28'
alias sshpi='ssh pi@192.168.1.102 -p 42'
alias sshlab='ssh tris@192.168.1.101 -p 42'

### various defaults
alias dconf-editor='dcond-editor --I-understand-that-changing-options-can-break-applications'

### history
alias histon='set -o history'
alias histoff='set +o history'

### daynight
alias dnd='daynight d && source $HOME/.bashrc && notify-send "Day"'
alias dnn='daynight n && source $HOME/.bashrc && notify-send "Night"'

# terminal_profile_switch() {
#       xdotool --clearmodifiers key Shift+F10 r $1
# }

terminal_profile_switch() {
	xdotool key --delay 50 Menu r $1
}
alias chp='terminal_profile_switch'

alias xdotool='windowsize $(xdotool getactivewindow) 100% 100%'

alias gnomere="dbus-send --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.reexec_self()'"
alias gnomek='DISPLAY=:0 gnome-shell -r'
alias gnome_build='sudo glib-compile-schemas /usr/share/glib-2.0/schemas'
alias gnomexts='cd /usr/share/gnome-shell/extensions'

vimpluginstall() {
	cd $HOME/dotfiles/vim/bundle/
	git clone $1
}

alias cdgninstall='cd $HOME/dotfiles/gnome_setup/'
alias vigninstall='vim $HOME/dotfiles/gnome_setup/install.sh'

alias eb='$EDITOR $HOME/dotfiles/bashrc'
alias ep='$EDITOR $HOME/dotfiles/bash_profile'
alias ea='$EDITOR $HOME/dotfiles/bash_aliases'
alias ev='$EDITOR $HOME/dotfiles/vimrc'
alias en='$EDITOR $HOME/dotfiles/inputrc'
alias et='$EDITOR $HOME/dotfiles/tmux.conf'
alias eh='$EDITOR $HOME/.bash_history'
alias efs='sudo $EDITOR /etc/fstab'
alias eapt='sudo $EDITOR /etc/apt/sources.list'
alias eg='sh .git/vimgit'

alias vb='vim $HOME/dotfiles/bashrc'
alias vp='vim $HOME/dotfiles/bash_profile'
alias va='vim $HOME/dotfiles/bash_aliases'
alias vv='vim $HOME/dotfiles/vimrc'
alias vn='vim $HOME/dotfiles/inputrc'
alias vt='vim $HOME/dotfiles/tmux.conf'
alias vh='vim $HOME/.bash_history'
alias vfs='sudo vim /etc/fstab'
alias vapt='sudo vim /etc/apt/sources.list'
alias vg='vim $(./.git/vimgit)'

alias vbashrc='vim $HOME/dotfiles/bashrc'
alias valias='vim $HOME/dotfiles/bash_aliases'
alias vimrc='vim $HOME/dotfiles/vimrc'
alias vinputrc='vim $HOME/dotfiles/inputrc'
alias vitmux='vim $HOME/dotfiles/tmux.conf'
alias vfstab='sudo vim /etc/fstab'
alias vapt='sudo vim /etc/apt/sources.list'
alias vmgit='sh .git/vimgit'

alias sbash='. $HOME/.bashrc'
alias smacbash='. $HOME/.bash_profile'
alias scolor='eval "$(dircolors $HOME/.dircolors)"'
alias salias='. $HOME/.bash_aliases'
alias sinputrc='bind -f ~/.inputrc'
alias stmux='tmux source-file $HOME/.tmux.conf'

alias sb='. $HOME/.bashrc'
alias sp='. $HOME/.bash_profile'
alias sc='eval "$(dircolors $HOME/.dircolors)"'
alias sa='. $HOME/.bash_aliases'
alias sn='bind -f ~/.inputrc'
alias sall='. $HOME/.bashrc ; . $HOME/.bash_aliases ; bind -f ~/.inputrc'
alias st='tmux source-file $HOME/.tmux.conf'

alias dot='cd $HOME/dotfiles'
alias dots='git -C $HOME/dotfiles status'
alias dotclh='git clone https://github.com/biggybi/dotfiles'
alias dotcl='git clone git@github.com:Biggybi/dotfiles'
alias dotssh='git clone git@github.com:Biggybi/dotfiles'

alias please='sudo $(fc -ln -1)'
alias pl='sudo $(fc -ln -1)'
alias modx='sudo chmod +x'

#tmux
alias tn='tmux_new_or_attach'
alias ta='tmux attach'
# alias o='xdg-open '
open() {
	xdg-open $1 &
}
alias o=open

# alias fzf='fzf --color="dark" --tabstop=4'
# alias fd='fd ~'
alias lcmd='echo "$(fc -ln -1)" | sed "s/^. *//"'
alias lcmdcp='echo "$(fc -ln -1)" | tr '\''\n'\'' '\'' '\'' | cip'
alias lcmdalias='echo "$(fc -ln -1)" | sed "s/^. *//" >> $DOT/bash_aliases'
alias hg='history | grep'
alias hx='eval $(history | sed "s/^ *[0-9]* *//" | fzf)'
alias ag='alias | grep'
alias pg='ps -aux | head -n -3 | grep'

## 42 piscine

newday() {
	if [ $1 != '.' ] | [ $# == 1 ]
	then
		mkdir d"$1"
		cd d"$1"
	fi
	mkdir ex00 ex01 ex02 ex03 ex04 ex05 ex06 ex07 ex08 ex09 ex10
}

alias gccfcday='gccf -c $(find ex* -name "*.c")'
alias gccmday='gccf main.c $(find . -name "*.c")'
alias vp='vi src/*.c inc*/*.h Makefile'

alias viday='vim $(find . -name "*.c")'
alias seer='tail -n -1 */*'
alias executer='for i in */*; do echo "$i"; sh "$i"; echo ; done ;'
alias emperess='for i in */*; do echo "==> $i <=="; cat "$i"; echo "= ex =" ; sh "$i"; echo ; done ;'
alias cemperess='for i in */*\.c; do echo "==> $i <=="; cat "$i"; echo "= ex =" ; gcc "$i" -o "${i::-2}"; gcc "${i::-2}"; echo ; done ;'

## apache server
alias www='cd /var/www/tristankapous'
alias viit='vim $(fc -ln -1)'
alias lsit='ls $(fc -ln -1)'
alias catit='cat $(fc -ln -1)'
alias cpit='cp $(fc -ln -1) '
alias mvit='mv $(fc -ln -1)'
alias rmit='rm $(fc -ln -1)'
alias echoit='echo $(fc -ln -1)'
alias gccit='gcc $(fc -ln -1)'

alias fg1='fg 1'
alias fg2='fg 2'
alias fg3='fg 3'
alias fg4='fg 4'
alias fg5='fg 5'

### Maintainance
alias apti='sudo apt install'

alias aptrm='sudo apt autoremove'
alias aptu='sudo apt update && notify-send "Update done"'
alias aptg='sudo apt upgrade'
alias aptd='sudo apt dist-upgrade'
alias apts='apt search'
alias aptl='apt list'
alias uuu='sudo apt update && sudo apt upgrade && notify-send "Update done"'
alias uu='sudo apt update && sudo apt upgrade&& notify-send "Update done"'
alias crashrm='sudo rm /var/crash/*'
alias rmDS='find . -name *.DS_Store -type f -delete'
alias myip='hostname -I | sed "s/\ .*//g"'

### Hardware info
alias piserial="sed '/Serial/!d; s/.*: 0\+//' /proc/cpuinfo"

alias myopt='sudo dpkg -S /opt/*'

alias pingg='ping -c 3 www.qwant.com'

alias cip='xsel -b'
alias pw='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
alias cdinstall='cd $HOME/Documents/Install/Ubuntu'
alias cd42='cd $ALIAS_42_HOME'
alias echo42='echo $ALIAS_42_HOME'
alias 42clone='git clone git@github.com:Biggybi/42.git'

alias lftcd='cd $ALIAS_42_LFT'
alias cdlft='cd $ALIAS_42_LFT'
alias lftmk='make -C $ALIAS_42_HOME/'
alias lftln='ln -s $ALIAS_42_LFT/ .'
alias lftls='ls $ALIAS_42_LFT/src/*.c | cut -d/ -f7'
alias lftcp='cp -ru $ALIAS_42_HOME/libft.a $ALIAS_42_LFT/includes/libft.h .'
alias lftcl='git clone git@github.com:Biggybi/libft'
alias lftccp='cp -rf $ALIAS_42_LFT/ .'
alias cdgnl='cd $ALIAS_42_HOME/GNL'
alias cdls='cd $ALIAS_42_HOME/ft_ls'
alias cdbin='cd $HOME/bin'
alias todoscript='vim $ALIAS_42_HOME/bin/.todo'

alias tmp='mkdir /tmp/TMP 2>/dev/null ; cd /tmp/TMP'
alias tmpclean='rm -r /tmp/TMP'


alias gcc='clang '
alias gccf='gcc -Wall -Wextra '
alias p='python3.7'
alias phpserv='php -S localhost:4000'
alias bc='bc -q'
alias asciid="man ascii | grep Tables -A15 | cut -c 25- | sed 's/^ /    /;s/$^//;1,2d;5d'"
alias asciidh="man ascii | grep ".*30.*40.*" -A18 -B1"

alias regex_ipv6='grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2}'
## alias regex_ipv4='grep -Eo \([0-9]*.\){3}[^0-9]*'

### config : app icons
alias cdapp='cd /usr/share/applications/'


alias r='fc -s'

##alias sedtrim="sed -n '1h;1!ALIAS_42_HOME;${;g;s/^[ \t]*//g;s/[ \t]*$//g;p;}'"

alias macflatmouse='defaults write .GlobalPreferences com.apple.mouse.scaling -1'
alias maclogout="osascript -e 'tell app \"System Events\" to log out'"
alias maclogoutf="osascript -e 'tell app \"System Events\" to «event aevtrlgo»'"

## Add an "alert" alias for long running commands.  Use like so:
##   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias freebox2='cd /run/user/1000/gvfs/smb-share:server=freebox-server.local,share=volume%202000go/'
alias freebox='cd /run/user/1000/gvfs/smb-share:server=freebox-server.local,share=disque%20dur/'

## file edition
## alias se='$EDITOR $(find ~/bin/* -type f | fzf)';
## se() { $EDITOR $(find ~/bin/* -type f | fzf);}
##eb() { find ~/bin/* -type f | fzf | xargs -r bash -c '</dev/tty  $EDITOR "$@"' ignorename ;}
alias fbin='$EDITOR $(find $HOME/bin/* -type f | sed s/*\//g | fzf -d/ -n5 --height=10)'
alias flft='$EDITOR $ALIAS_42_LFT/src/$(find $ALIAS_42_LFT/src -type f -exec basename {} \; | fzf --height=10 --preview="cat $ALIAS_42_LFT/src/{}")'
# alias ev='$EDITOR $(fzf --height=10)'

get_hidden_mail_adress() {
	grep "at.*dot" $1 | sed 's/\bdot\b/./g;s/\bat\b/\@/;s/[[:space:]]//g'
}

# alias fav='. fav'
# vim: filetype=sh

# firefox
alias foxn='firefox -new-window '
alias foxyt='firefox -new-window youtube.com'

# youtube dl
alias ydl='youtube-dl'

# terminal web apps
alias meteo="curl wttr.in"
alias pubip="pubip"
alias pubcity="pubip city"
alias pubcountry="pubcountry"

tinyurl() {
	curl -s http://tinyurl.com/api/create.php\?url\=$1
}

#caps2escape
alias c2e='caps2esc'
alias cc='c2e 2&> /dev/null ; clear'

change_shell() {
	chsh -s $(which $1)
}

## FZF functions

ef() {
	cd "$1"
	P=$(fzf --height=60%)
	[ "$P" != "" ] && $EDITOR $P
}
# alias f='ef $HOME'

# fd - cd to selected directory
# fd() {
# 	local dir
# 	dir=$(find ${1:-.} -path '*/\.*' -prune \
# 		-o -type d -print 2> /dev/null | fzf +m) &&
# 		cd "$dir"
# }

# fd - cd to selected directory

fo() {
	fzf | open -
}

fd() {
	dir=$(find -L ${1:-~} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf --height=10 --preview="ls -p --color=always {}") && cd "$dir"
}

fzv() {
	cd $HOM_VID
	[ $HOM_VID ] && find $HOM_VID/* \( ! -regex '.*/\..*/..*' \) -type f | sed 's/^.*Videos\///' | fzf --preview="" | sed 's/*//g;s/$/\"/;s/^/"/'|  xargs -r vlc
}

fzm() {
	cd $HOM_MUS
	[ $HOM_MUS ] && find $HOM_MUS/* \( ! -regex '.*/\..*/..*' \) -type f | sed 's/^.*Music\///' | fzf --preview="" | sed 's/*//g;s/$/\"/;s/^/"/'|  xargs -r vlc
}

fzf_semi_interactive_cd() {
	if [[ "$#" != 0 ]]; then
		builtin cd "$@";
		return
	fi
	while true
	do
		local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
		local dir="$(printf '%s\n' "${lsd[@]}" |
			fzf --reverse --preview '
					__cd_nxt="$(echo {})";
					__cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
					echo $__cd_path;
					echo;
					ls -p --color=always "${__cd_path}";
					')"
		[[ ${#dir} != 0 ]] || return 0
		builtin cd "$dir" &> /dev/null
	done
}
