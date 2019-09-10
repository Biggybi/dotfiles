ALIAS_101_HOME=$HOME/101
ALIAS_101_LFT=$HOME/101/libft

shopt -s expand_aliases

## color
alias ls='ls -h --group-directories-first --color=auto'
alias dir='dir -color=auto'
alias vdir='vdir --color=auto'
if [[ "$OSTYPE" == "darwin"* ]]
then
	alias ls='ls -h'
fi

#caps2escape
alias c2e='caps2esc'

## 42 piscine
newday () {
	if [ $1 != '.' ] | [ $# == 1 ]
	then
		mkdir d"$1"
		cd d"$1"
	fi
	mkdir ex00 ex01 ex02 ex03 ex04 ex05 ex06 ex07 ex08 ex09 ex10
}
alias viday='vim $(find . -name "*.c")'
alias gccfcday='gccf -c $(find ex* -name "*.c")'
alias gccmday='gccf main.c $(find . -name "*.c")'
alias vp='vi src/*.c inc/*.h Makefile'

## grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## ls
alias ll='ls -trhalF'
alias la='ls -lA'
alias l='ls -CF'
alias lsd='find . -maxdepth 1 -type f -name ".*" -exec basename {} \;'

alias le='less'
alias ccat='highlight --out-format=ansi'

## df
alias df='df -h'

## free
alias free='free -h'

## vim
alias e="$EDITOR"
alias v="vim"
alias vi='vim'
alias sv="sudo vim"

### ssh
alias sshhome='ssh biggybi@192.168.1.28'
alias sshpi='ssh pi@192.168.1.101 -p 42'

### various defaults
alias dconf-editor='dcond-editor --I-understand-that-changing-options-can-break-applications'

### history
alias histon='set -o history'
alias histoff='set +o history'

### daynight
alias dnd='daynight d && source $HOME/.bashrc'
alias dnn='daynight n && source $HOME/.bashrc'

alias gnomere="dbus-send --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.reexec_self()'"
alias gnomek='DISPLAY=:0 gnome-shell -r'
alias gnome_build='sudo glib-compile-schemas /usr/share/glib-2.0/schemas'
alias gnomexts='cd /usr/share/gnome-shell/extensions'

alias cdgninstall='cd $HOME/dotfiles/gnome_setup/'
alias vigninstall='vim $HOME/dotfiles/gnome_setup/install.sh'

alias vibashrc='vim $HOME/dotfiles/bashrc'
alias vialias='vim $HOME/dotfiles/bash_aliases'
alias vimrc='vim $HOME/dotfiles/vimrc'
alias viinputrc='vim $HOME/dotfiles/inputrc'
alias vifstab='sudo vim /etc/fstab'
alias viapt='sudo vim /etc/apt/sources.list'

alias sobash='. $HOME/.bashrc'
alias somacbash='. $HOME/.bash_profile'
alias socolor='eval "$(dircolors $HOME/.dircolors)"'
alias soalias='. $HOME/.bash_aliases'

alias dot='cd $HOME/dotfiles'
alias dots='git -C $HOME/dotfiles status'
alias dotclone='git clone https://github.com/biggybi/dotfiles'
alias dotclssh='git clone git@github.com:Biggybi/dotfiles'
alias dotssh='git clone git@github.com:Biggybi/dotfiles'

alias please='sudo $(fc -ln -1)'
alias pl='sudo $(fc -ln -1)'
alias modx='sudo chmod +x'

# alias o='xdg-open '
open () {
	xdg-open $1 &
}
alias o=open
alias fzf='fzf --color="dark" --tabstop=4'
# alias fd='fd ~'
alias lcmd='echo "$(fc -ln -1)" | sed "s/^. *//"'
alias lcmdcp='echo "$(fc -ln -1)" | tr '\''\n'\'' '\'' '\'' | cip'
alias lcmdalias='echo "$(fc -ln -1)" | sed "s/^. *//" >> $DOT/bash_aliases'
alias hg='history | grep'
alias hx='eval $(history | sed "s/^ *[0-9]* *//" | fzf)'
alias ag='alias | grep'
alias pg='ps -aux | head -n -3 | grep'

alias seer='tail -n -1 */*'
alias executer='for i in */*; do echo "$i"; sh "$i"; echo ; done ;'
alias emperess='for i in */*; do echo "==> $i <=="; cat "$i"; echo "= ex =" ; sh "$i"; echo ; done ;'
alias cemperess='for i in */*\.c; do echo "==> $i <=="; cat "$i"; echo "= ex =" ; gcc "$i" -o "${i::-2}"; gcc "${i::-2}"; echo ; done ;'

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
alias aptu='sudo apt update'
alias aptg='sudo apt upgrade'
alias aptd='sudo apt dist-upgrade'
alias apts='apt search'
alias uuu='aptu && aptd && aptg'
alias uu='aptu && aptg'
alias crashrm='sudo rm /var/crash/*'
alias rmDS='find . -name *.DS_Store -type f -delete'
alias myip='hostname -I | sed "s/\ .*//g"'

### Hardware info
alias piserial="sed '/Serial/!d; s/.*: 0\+//' /proc/cpuinfo"

alias myopt='sudo dpkg -S /opt/*'

alias pingg='ping -c 3 www.qwant.com'

alias cip='xsel -b'
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
alias cdinstall='cd $HOME/Documents/Install/Ubuntu'
alias cd101='cd $ALIAS_101_HOME'
alias echo101='echo $ALIAS_101_HOME'
alias 101clone='git clone git@github.com:Biggybi/101.git'

alias lftcd='cd $ALIAS_101_LFT'
alias cdlft='cd $ALIAS_101_LFT'
alias lftmk='make -C $ALIAS_101_HOME/'
alias lftln='ln -s $ALIAS_101_LFT/ .'
alias lftls='ls $ALIAS_101_LFT/src/*.c | cut -d/ -f7'
alias lftcp='cp -ru $ALIAS_101_HOME/libft.a $ALIAS_101_LFT/inc/libft.h .'
alias lftccp='cp -rf $ALIAS_101_LFT/ .'
alias cdgnl='cd $ALIAS_101_HOME/GNL'
alias cdls='cd $ALIAS_101_HOME/ft_ls'
alias cdbin='cd $HOME/bin'
alias todoscript='vim $ALIAS_101_HOME/bin/.todo'

alias tmp='mkdir /tmp/TMP 2>/dev/null ; cd /tmp/TMP'
alias tmpclean='rm -r /tmp/TMP'

alias g='git'
alias gd='git diff'

alias g='git'
alias gurl='git config --get remote.origin.url'
alias gg='cd $(git rev-parse --show-toplevel)' #go to the root of a git repo
alias gitroot='cd $(git rev-parse --show-toplevel)' #go to the root of a git repo
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

alias gcc='clang '
alias gccf='gcc -Wall -Wextra '

alias bc='bc -q'
alias asciid="man ascii | grep Tables -A15 | cut -c 25- | sed 's/^ /    /;s/$^//;1,2d;5d'"
alias asciidh="man ascii | grep ".*30.*40.*" -A18 -B1"

alias regex_ipv6='grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2}'
## alias regex_ipv4='grep -Eo \([0-9]*.\){3}[^0-9]*'

### config : app icons
alias cdapp='cd /usr/share/applications/'

alias ydl='youtube-dl'

##alias sedtrim="sed -n '1h;1!ALIAS_101_HOME;${;g;s/^[ \t]*//g;s/[ \t]*$//g;p;}'"

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
alias eb='$EDITOR $(find $HOME/bin/* -type f | sed s/*\//g | fzf -d/ -n5 --height=10)'
alias elft='$EDITOR $ALIAS_101_LFT/src/$(find $ALIAS_101_LFT/src -type f -exec basename {} \; | fzf --height=10)'
# alias ev='$EDITOR $(fzf --height=10)'

## FZF functions

ef () {
	# 	P=$(ps | sed -n "/fzf/p" | sed "s/.pts.*//g;s/\ //")
	cd "$1"
	P=$(fzf --height=10)
	[ "$P" != "" ] && $EDITOR $P
}
# alias f='ef $HOME'

# fd - cd to selected directory
# fd () {
# 	local dir
# 	dir=$(find ${1:-.} -path '*/\.*' -prune \
# 		-o -type d -print 2> /dev/null | fzf +m) &&
# 		cd "$dir"
# }
fd () {
	local dir
	dir=$(find ${1:-~} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf +m) &&
		cd "$dir"
}


get_hidden_mail_adress () {
	grep "at.*dot" $1 | sed 's/\bdot\b/./g;s/\bat\b/\@/;s/[[:space:]]//g'
}

alias ex='return && echo end'
# alias fav='. fav'
# vim: filetype=sh

# firefox
alias ffn='firefox -new-window '
alias fyt='firefox -new-window youtube.co'
