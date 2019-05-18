ALIAS_101_HOME=~/101
ALIAS_101_LFT=~/101/libft

# color
alias ls='ls -hN --group-directories-first --color=auto'
alias dir='dir -color=auto'
alias vdir='vdir --color=auto'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls
alias ll='ls -trhalF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='find . -type f -name ".*" | sed s/.*\\///'
alias le='less'

# df
alias df='df -h'

# vi
alias e="$EDITOR"
alias v="vi"
alias sv="sudo vi"

## ssh
alias sshhome='ssh biggybi@192.168.1.28'
alias sshpi='ssh pi@192.168.1.101 -p 42'

## various defaults
alias dconf-editor='dcond-editor --I-understand-that-changing-options-can-break-applications'

## Mes alias

alias gnomere="dbus-send --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.reexec_self()'"
alias gnomek='DISPLAY=:0 gnome-shell -r'
alias gnome_build='sudo glib-compile-schemas /usr/share/glib-2.0/schemas'
alias gnomexts='cd /usr/share/gnome-shell/extensions'
alias cdgninstall='cd $HOME/.dotfiles/gnome_setup/'
alias vigninstall='vi $HOME/.dotfiles/gnome_setup/install.sh'

alias aliasme='. aliasme'
alias vibashrc='vi ~/.bashrc'
alias vialias='vi ~/.bash_aliases'
alias vimrc='vi ~/.vimrc'

alias vifstab='sudo vi /etc/fstab'

alias sobash='. ~/.bashrc'
alias somacbash='. ~/.bash_profile'
alias socolor='eval "$(dircolors ~/.dircolors)"'
alias soalias='. ~/.bash_aliases'

alias dot='cd ~/.dotfiles'
alias dots='git -C ~/.dotfiles status'
alias dotclone='git clone https://github.com/biggybi/dotfiles'
alias dotclssh='git clone git@github.com:Biggybi/dotfiles'
alias dotssh='git clone git@github.com:Biggybi/dotfiles'

alias please='sudo $(fc -ln -1)'
alias pl='sudo $(fc -ln -1)'
alias modx='sudo chmod +x'

alias lcmd='echo "$(fc -ln -1)" | xargs'
alias lcmdcp='lcmd | cip'
alias hg='history | grep'
alias ag='alias | grep'
alias pg='ps -aux | head -n -3 | grep'

alias viit='vi $(fc -ln -1)'
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


## Maintainance
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

## Hardware info
alias piserial="sed '/Serial/!d; s/.*: 0\+//' /proc/cpuinfo"

alias myopt='sudo dpkg -S /opt/*'

alias pingg='ping -c 3 www.qwant.com'

alias cip='xsel -b'
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
alias cdinstall='cd ~/Documents/Install/Ubuntu'
alias cd101='cd $ALIAS_101_HOME'
alias echo101='echo $ALIAS_101_HOME'
alias 101clone='git clone git@github.com:Biggybi/101.git'

alias lftcd='cd $ALIAS_101_HOME/lft'
alias cdlft='cd $ALIAS_101_HOME/lft'
alias lftmk='make -C $ALIAS_101_HOME/lft'
alias lftln='ln -s $ALIAS_101_HOME/lft/ .'
alias lftls='ls $ALIAS_101_HOME/lft/srcs/*.c | cut -d/ -f7'
alias lftcp='cp -ru $ALIAS_101_HOME/lft/lft.a $ALIAS_101_HOME/lft/includes/lft.h .'
alias lftccp='cp -rf $ALIAS_101_HOME/lft/ .'
alias cdgnl='cd $ALIAS_101_HOME/GNL'
alias cdls='cd $ALIAS_101_HOME/Ft_ls'
alias cdscript='cd $ALIAS_101_HOME/bin'
alias todoscript='vi $ALIAS_101_HOME/.bin/.todo'

alias tmp='mkdir /tmp/TMP 2>/dev/null ; cd /tmp/TMP'
alias tmpclean='rm -r /tmp/TMP'

alias gitroot='cd $(git rev-parse --show-cdup)' #go to the root of a git repo
alias gitmodif='git diff-files -z --diff-filter=M --name-only --relative | xargs -0 git add'
alias gits='git status '
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

alias regex_ipv6='grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2}'
# alias regex_ipv4='grep -Eo \([0-9]*.\){3}[^0-9]*'

## config : app icons
alias cdapp='cd /usr/share/applications/'

alias ydl='youtube-dl --audio-quality 0 '

#alias sedtrim="sed -n '1h;1!ALIAS_101_HOME;${;g;s/^[ \t]*//g;s/[ \t]*$//g;p;}'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias macflatmouse='defaults write .GlobalPreferences com.apple.mouse.scaling -1'
alias maclogout="osascript -e 'tell app \"System Events\" to log out'"
alias maclogoutf="osascript -e 'tell app \"System Events\" to «event aevtrlgo»'"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias freebox2='cd /run/user/1000/gvfs/smb-share:server=freebox-server.local,share=volume%202000go/'
alias freebox='cd /run/user/1000/gvfs/smb-share:server=freebox-server.local,share=disque%20dur/'

# file edition
# alias se='$EDITOR $(find ~/.bin/* -type f | fzf)';
# se() { $EDITOR $(find ~/.bin/* -type f | fzf);}
#eb() { find ~/.bin/* -type f | fzf | xargs -r bash -c '</dev/tty  $EDITOR "$@"' ignorename ;}
alias eb='$EDITOR $(find ~/.bin/* -type f | sed s/*\//g | fzf)'
alias elft='$EDITOR $(find $ALIAS_101_LFT/src -type f | fzf)'

