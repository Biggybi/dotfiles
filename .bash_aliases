H=~/101
#H=/home/biggybi
# color
alias ls='ls -G'
alias dir='dir -G'
alias vdir='vdir -G'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#ls
alias ll='ls -trhalF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='find . -type f -name ".*" | sed s/.*\\///'

## Mes alias

alias macflatmouse='defaults write .GlobalPreferences com.apple.mouse.scaling -1'
alias maclogout="osascript -e 'tell app \"System Events\" to log out'"
alias maclogoutf="osascript -e 'tell app \"System Events\" to «event aevtrlgo»'"

alias REgnome="dbus-send --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.reexec_self()'"
alias aliasme='. aliasme'
alias vibashrc='vi ~/.bashrc'
alias vialias='vi ~/.bash_aliases'
alias vimrc='vi ~/.vimrc'

alias sobash='. ~/.bashrc'
alias somacbash='. ~/.bash_profile'
alias socolor='eval "$(dircolors ~/.dircolors)"'
alias soalias='. ~/.bash_alias'

alias dot='cd ~/.dotfiles'
alias dotgits='dots && git status'

alias please='sudo $(fc -ln -1)'
alias modx='sudo chmod +x'

alias lcmd='echo $(fc -ln -1)'
alias lcmdcp='lcmd | cip'
alias hg='history | grep '

alias viit='vi $(fc -ln -1)'
alias lsit='ls $(fc -ln -1)'
alias catit='cat $(fc -ln -1)'
alias cpit='cp $(fc -ln -1) '
alias mvit='mv $(fc -ln -1)'
alias rmit='rm $(fc -ln -1)'
alias echoit='echo $(fc -ln -1)'
alias gccit='gcc $(fc -ln -1)'


## Maintainance
alias apti='sudo apt install'
alias aptrm='sudo apt autoremove'
alias aptu='sudo apt update'
alias aptg='sudo apt upgrade'
alias aptd='sudo apt dist-upgrade'
alias uuu='aptu && aptd && aptg'
alias uu='aptu && aptg'
alias crashrm='sudo rm /var/crash/*'
alias rmDS='find . -name *.DS_Store -type f -delete'
alias myopt='sudo dpkg -S /opt/*'


alias cip='xsel -b'
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
alias cdinstall='cd /mnt/Data/Documents/Install/Ubuntu'
alias cd42='cd $H/42'
alias echoh='echo $H'

alias lftcd='cd $H/lft'
alias cdlft='cd $H/lft'
alias lftmk='make -C $H/lft'
alias lftln='ln -s $H/lft/ .'
alias lftls='ls $H/lft/srcs/*.c | cut -d/ -f7'
alias lftcp='cp -ru $H/lft/lft.a $H/lft/includes/lft.h .'
alias lftccp='cp -rf $H/lft/ .'
alias cdgnl='cd $H/GNL'
alias cdls='cd $H/Ft_ls'
alias cdscript='cd $H/bin'
alias todoscript='vi $H/.bin/.todo'

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

alias gccf='gcc -Wall -Wextra '

alias bc='bc -q'

alias regex_ipv4='grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2}'

## config : app icons
alias cdapp='cd /usr/share/applications/'

#alias sedtrim="sed -n '1h;1!H;${;g;s/^[ \t]*//g;s/[ \t]*$//g;p;}'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
