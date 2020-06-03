# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    vim_install.sh                                   .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: tris <tristan.kapous@protonmail.com>       +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/02/16 20:09:29 by tris         #+#   ##    ##    #+#        #
#    Updated: 2020/02/16 20:10:14 by tris        ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

#!/bin/bash

sudo apt install libncurses5-dev libgtk2.0-dev libatk1.0-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
	python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

VIMSOURCE=/tmp/vim_install

[ -d $VIMSOURCE ] || git clone https://github.com/vim/vim.git $VIMSOURCE
cd $VIMSOURCE/src
make distclean
cd $VIMSOURCE

./configure \
	--enable-multibyte \
	--enable-perlinterp=dynamic \
	--enable-rubyinterp=dynamic \
	--with-ruby-command=/usr/bin/ruby \
	--enable-python3interp \
	--with-python3-config-dir=/usr/bin/python3 \
	--enable-luainterp \
	--with-luajit \
	--enable-cscope \
	--enable-gui=auto \
	--with-features=huge \
	--enable-gtk-2-check \
	--enable-gnome-check \
	--with-x \
	--enable-fontset \
	--enable-largefile \
	--disable-netbeans \
	--enable-fail-if-missing

make
sudo make install
