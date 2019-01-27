# color
alias ls='ls -FG'
alias dir='dir -FG'
alias vdir='vdir -FG'

alias grep='grep -FG'
alias fgrep='fgrep -FG'
alias egrep='egrep -FG'

#ls
alias ll='ls -trhalF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='find . -type f -name ".*" | sed s/.*\\///'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Mes alias

##alias audio_switch='xmacroplay -d 0 < ~/Documents/Macros/switch_audio_output'
alias macflatmouse='defaults write .GlobalPreferences com.apple.mouse.scaling -1'
alias maclogout="osascript -e 'tell app \"System Events\" to log out'"
alias maclogoutf="osascript -e 'tell app \"System Events\" to «event aevtrlgo»'"

##alias s!='sudo "$BASH" -c "$(history -p !!)"'
alias REgnome="dbus-send --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.reexec_self()'"
alias aliasme='. aliasme'
alias vibashrc='vi ~/.bashrc'
alias vialias='vi ~/.bash_aliases'
alias vimrc='vi ~/.vimrc'
alias REbash='. ~/.bash_profile ; . ~/.bash_aliases'
alias REcolor='eval "$(dircolors ~/.dircolors)"'

alias please='sudo $(fc -ln -1)'
##alias lcmd='history | tail -n2 | head -n 1 | cut -d" " -f4-'
##alias lcmd='echo !!'
##alias lcmdcp='lcmd | xsel -b'
alias lcmd='echo $(fc -ln -1)'
alias lcmdcp='lcmd | cip'
alias hg='history | grep '

alias viit='vi !$'
alias lsit='ls !$'
alias catit='cat !$'
alias cpit='cp !$'
alias mvit='mv !$'
alias rmit='rm !$'
alias echoit='echo !$'
alias gccit='gcc !$'


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
alias cd42='cd /home/biggybi/42'
alias libftcd='cd ~/101/libft'
alias cdlibft='cd ~/101/libft'
alias libftmk='make -C ~/101/libft/'
alias libftln='ln -s ~/101/libft/ .'
alias libftls='ls ~/101/libft/src/*.c | cut -d/ -f7'
alias libftls='ls ~/101/libft/src/*.c | cut -d/ -f7'
alias libftcp='cp -r ~/101/libft/libft.a ~/101/libft/inc/libft.h .'
alias libftccp='cp -rf ~/101/libft/ .'
alias cdgnl='cd /home/biggybi/42/GNL'
alias cdls='cd /home/biggybi/42/Ft_ls'
alias cdscript='cd /home/biggybi/bin'
alias todoscript='vi /home/biggybi/.bin/.todo'
alias tmp='mkdir /tmp/TMP 2>/dev/null ; cd /tmp/TMP'
alias tmpclean='rm -r /tmp/TMP'

alias gitroot='cd $(git rev-parse --show-cdup)' #go to the root of a git repo
alias gitmodif='git diff-files -z --diff-filter=M --name-only --relative | xargs -0 git add'
alias gits='git status'
alias gau='git add -u'
alias gcl='git clone'
alias grm='git rm --cached'
alias grmf='git rm -f'
alias gps='git push"
alias gpl='git pull'
alias gcm='git commit -m'
alias gita='git add'

alias gccf='gcc -Wall -Wextra -Werror'
alias ms='echo you fuckin missclick you jerk'

alias bc='bc -q'

alias regex_ipv4='grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2}'

## config : app icons
alias cdapp='cd /usr/share/applications/'
