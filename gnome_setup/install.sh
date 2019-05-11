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
	rm -rf $HOME/$f
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

# never prompt for upgrades
sudo sed -i s/Prompt=normal/Prompt=never/ /etc/update-manager/release-upgrades

#gdm3
sudo apt-get install -yy gdm3
sudo update-alternatives --config gdm3.css

#copy extensions
sudo cp -r extensions/* /usr/share/gnome-shell/extensions/

#set theme
sudo cp -r themes/Materia-dark /usr/share/themes
sudo cp -r themes/Materia-light /usr/share/themes
sudo cp -r themes/Materia-light-compact /usr/share/themes
sudo cp -r themes/Materia-dark-compact /usr/share/themes
cp -r autostart $HOME/.config/autostart/

#todo : cp wallpapers
#mkdir $HOME/Wallpapers

#fusuma
sudo apt-get install -yy ruby
sudo gpasswd -a $USER input
#sudo snap install --classic ruby
sudo gem install fusuma
gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
cp -r fusuma ~/.config

# gnome theme
gsettings set org.gnome.desktop.interface gtk-theme Materia-dark
gsettings set org.gnome.desktop.interface gtk-theme Materia
