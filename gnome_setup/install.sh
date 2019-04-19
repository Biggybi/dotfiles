#!/bin/bash

sudo apt-get update -qq
sudo apt-get upgrade
sudo apt-get autoremove

sudo apt-get install -yy git
sudo apt-get install -yy make
sudo apt-get install -yy cmake
sudo apt-get install -yy autotool
sudo apt-get install -yy gcc
sudo apt-get install -yy build-essential

sudo apt-get install -yy clang
sudo apt-get install -yy openssh-server
udo apt-get install -yy vim

sudo apt-get install -yy gnome-session
sudo apt-get install -yy gnome-tweaks
sudo apt-get install -yy chrome-gnome-shell
sudo update-alternatives --config gdm3.css

sudo apt-get-get install -yy libinput-tools
sudo apt-get-get install -yy xdotool
sudo apt-get-get install -yy curl

# never prompt for upgrades

sudo sed -i s/Prompt=normal/Prompt=never/ /etc/update-manager/release-upgrades

#gdm3
sudo apt-get install gdm3

#copy extensions
sudo cp -r extensions/* /usr/share/gnome-shell/extensions/

#set theme
sudo cp -r themes/Materia-dark /usr/share/themes
sudo cp -r themes/Materia-dark-compact /usr/share/themes

#fusuma
sudo gpasswd -a $USER input
sudo snap install -yy ruby
gem install -yy fusuma
gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
cp -r fusuma ~/.config
