#!/bin/sh

sudo apt-get install git gcc make pkg-config libx11-dev libxtst-dev libxi-dev

# install xcape
cd xcape
make
sudo make install
cd ..

cp xmodmap.conf ${HOME}/.xmodmap.conf
. $HOME/bin/caps2esc
