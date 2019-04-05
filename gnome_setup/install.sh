sudo apt update
sudo apt upgrade
sudo apt autoremove

sudo apt install git
sudo apt install make
sudo apt install autotool
sudo apt install gcc
sudo apt install clang
sudo apt install vim

sudo apt install gnome-session
sudo apt install gnome-tweaks
sudo apt install chrome-gnome-shell
sudo update-alternatives --config gdm3.css

sudo apt-get install libinput-tools
sudo apt-get install xdotool
sudo apt install xclip

sudo snap install spotify

sudo apt update
sudo apt upgrade
sudo apt autoremove

#copy extensions
sudo cp -r extensions/* /usr/share/gnome-shell/extensions/

#set theme
sudo cp -r themes/Materia-dark /usr/share/themes
sudo cp -r themes/Materia-dark-compact /usr/share/themes

#fusuma
sudo gpasswd -a $USER input
sudo snap install ruby
gem install fusuma
gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
cp -r fusuma ~/.config
