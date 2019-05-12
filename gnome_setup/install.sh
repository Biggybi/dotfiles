#!/bin/bash

# home
# sets media folders as simlinks to folders in DATA
DATA=/data
for f in $DATA/*
do
	f=$(basename $f)
	echo $HOME/$f
	echo f = $f
	echo
	if [ -d $HOME/$f ]
	then
		rm -rf $HOME/$f
	fi
	echo rm $HOME/$f
	if ! [ -L $HOME/$f ]
	then
		ln -s $DATA/$f $HOME
	fi
done

#programs install

sudo apt-get update -qq
sudo apt-get upgrade -y
sudo apt-get autoremove -y

sudo apt-get install -yy git
sudo apt-get install -yy gcc
sudo apt-get install -yy make
sudo apt-get install -yy cmake
sudo apt-get install -yy autotools-dev
sudo apt-get install -yy autoconf
sudo apt-get install -yy build-essential
sudo apt-get install -yy ethtool			# WOL
sudo apt-get install -yy fzf

sudo apt-get install -yy clang
sudo apt-get install -yy openssh-server
sudo apt-get install -yy vim

sudo apt-get install -yy gnome-session
sudo apt-get install -yy gnome-tweaks
sudo apt-get install -yy dconf-editor
sudo apt-get install -yy chrome-gnome-shell

sudo apt-get install -yy libinput-tools
sudo apt-get install -yy xdotool
sudo apt-get install -yy curl
sudo apt-get install -yy lm-sensors
sudo apt-get install -yy xsel

sudo apt-get install -yy vlc
sudo apt-get install -yy epiphany-browser

sudo snap install slack

cp -r autostart $HOME/.config/autostart/

# never prompt for upgrades
sudo sed -i s/Prompt=normal/Prompt=never/ /etc/update-manager/release-upgrades
# gsettings set com.ubuntu.update-notifier release-check-time 1557449824

#gdm3
sudo apt-get install -yy gdm3
sudo cp themes/gdm3.css /usr/share/gnome-shell/theme/gdm3.css
sudo update-alternatives --config gdm3.css

# copy extensions
sudo cp -r extensions/* /usr/share/gnome-shell/extensions/

# copy theme
sudo cp -r themes/Materia-dark /usr/share/themes
sudo cp -r themes/Materia-light /usr/share/themes
sudo cp -r themes/Materia-dark /usr/share/gnome-shell/themes
sudo cp -r themes/Materia-light /usr/share/gnome-shell/themes


#todo : cp wallpapers
#mkdir $HOME/Wallpapers

#fusuma
sudo apt-get install -yy ruby
sudo gpasswd -a $USER input
#sudo snap install --classic ruby
sudo gem install fusuma
gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
cp -r fusuma ~/.config

# epiphany
gsettings set org.gnome.Epiphany.ui tabs-bar-visibility-policy 'always'
gsettings set org.gnome.Epiphany.web:/org/gnome/epiphany/web/ enable-user-css true
gsettings set org.gnome.Epiphany default-search-engine 'qwant'
gsettings set org.gnome.Epiphany search-engines "[('qwant', 'https://www.qwant.com/?q=%s&t=web', 'qw'), ('Google', 'https://www.google.com/search?client=ubuntu&channel=es&q=%s', '!g'), ('DuckDuckGo', 'https://duckduckgo.com/?q=%s&amp;t=canonical', '!ddg')]"
gsettings set org.gnome.Epiphany.reader color-scheme 'dark'
gsettings set org.gnome.Epiphany.sync sync-bookmarks-enabled true
gsettings set org.gnome.Epiphany.sync sync-bookmarks-initial false
gsettings set org.gnome.Epiphany.sync sync-bookmarks-time 1557607657
gsettings set org.gnome.Epiphany.sync sync-passwords-enabled true
gsettings set org.gnome.Epiphany.sync sync-passwords-initial false
gsettings set org.gnome.Epiphany.sync sync-passwords-time 1557607657
gsettings set org.gnome.Epiphany.sync sync-user 'biggybi@gmail.com'
gsettings set org.gnome.Epiphany.sync sync-with-firefox true

# gnome theme
gsettings set org.gnome.desktop.interface gtk-theme Materia-dark
gsettings set org.gnome.desktop.interface gtk-theme Materia

# night light
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 3632

# sound
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true

# gnome wm
gsettings set org.gnome.desktop.wm.preferences button-layout ':appmenu,minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences audible-bell false

# gnome screensaver
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png'
gsettings set org.gnome.desktop.session idle-delay 900

# gnome calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

# gnome input source
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
gsettings set org.gnome.desktop.input-sources xkb-options ['caps:ctrl_modifier']

# gnome keyboard
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true

# gnome privacy
gsettings set org.gnome.desktop.privacy remember-app-usage false
gsettings set org.gnome.desktop.privacy remember-recent-files false

# gnome interface
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface cursor-theme 'whiteglass'

# dash to dock
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
gsettings set org.gnome.shell.extensions.dash-to-dock background-color '#2e3436'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.0
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color true
gsettings set org.gnome.shell.extensions.dash-to-dock customize-alphas true
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots true
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-color '#babdb6'
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces false
gsettings set org.gnome.shell.extensions.dash-to-dock max-alpha 1.0
gsettings set org.gnome.shell.extensions.dash-to-dock min-alpha 0.0
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'CILIORA'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'switch-workspace'
gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites true
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'

# dash to panel
gsettings set /org/gnome/shell/extensions/dash-to-panel/click-action 'CYCLE'
gsettings set /org/gnome/shell/extensions/dash-to-panel/dot-style-focused 'CILIORA'
gsettings set /org/gnome/shell/extensions/dash-to-panel/isolate-workspaces true
gsettings set /org/gnome/shell/extensions/dash-to-panel/location-clock 'BUTTONSRIGHT'
gsettings set /org/gnome/shell/extensions/dash-to-panel/show-favorites false
gsettings set /org/gnome/shell/extensions/dash-to-panel/taskbar-position 'LEFTPANEL_FIXEDCENTER'
gsettings set /org/gnome/shell/extensions/dash-to-panel/panel-size 55
gsettings set /org/gnome/shell/extensions/dash-to-panel/tray-size 20

gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-bg-color '#383838'
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-panel-opacity 0.0
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-bg-color '#383838'
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-dynamic-anim-target 1.0
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-dynamic-distance 1
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-gradient-bottom-color '#000000'
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-gradient-bottom-opacity 0.0
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-gradient-top-color '#383838'
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-gradient-top-opacity 0.35
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-bg true
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-gradient true
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-opacity true
gsettings set /org/gnome/shell/extensions/dash-to-panel/trans-use-dynamic-opacity true
gsettings set /org/gnome/shell/extensions/dash-to-panel/tray-size 20

gsettings set /org/gnome/shell/extensions/dash-to-panel/dot-color-override true
gsettings set /org/gnome/shell/extensions/dash-to-panel/dot-color-1 '#BABDB6'
gsettings set /org/gnome/shell/extensions/dash-to-panel/dot-color-2 '#BABDB6'
gsettings set /org/gnome/shell/extensions/dash-to-panel/dot-color-3 '#BABDB6'
gsettings set /org/gnome/shell/extensions/dash-to-panel/dot-color-4 '#BABDB6'

# desktop icons
gsettings set org.gnome.shell.extensions.desktop-icons show-home false
gsettings set org.gnome.shell.extensions.desktop-icons show-trash false

# open weather
gsettings set /org/gnome/shell/extensions/openweather/city '45.7622, 4.8263>Lyon>-1'
gsettings set /org/gnome/shell/extensions/openweather/days-forecast 3
gsettings set /org/gnome/shell/extensions/openweather/position-in-panel 'center'
gsettings set /org/gnome/shell/extensions/openweather/pressure-unit 'hPa'
gsettings set /org/gnome/shell/extensions/openweather/refresh-interval-current 600
gsettings set /org/gnome/shell/extensions/openweather/refresh-interval-forecast 1800
gsettings set /org/gnome/shell/extensions/openweather/unit 'celsius'
gsettings set /org/gnome/shell/extensions/openweather/wind-speed-unit 'kph'

# gnome-shell
gsettings set org.gnome.shell enabled-extensions ['gsconnect@andyholmes.github.io', 'openweather-extension@jenslody.de', 'dash-to-panel@jderose9.github.com', 'dash-to-dock@micxgx.gmail.com', 'user-theme@gnome-shell-extensions.gcampax.github.com']

# favorite apps
gsettings set org.gnome.shell favorite-apps ['org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Epiphany.desktop', 'firefox.desktop', 'piavpn.desktop', 'org.gnome.tweaks.desktop']

# gnome terminal
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ scrollbar-policy 'never'
