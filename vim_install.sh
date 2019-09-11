#!/bin/bash

INSTALLDIR=/usr/local/share/vim/vim81
VIMSOURCE=$HOME/dotfiles/programs/vim
PYTHONCONF=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu
[ -d $VIMSOURCE ] || git clone https://github.com/vim/vim.git $VIMSOURCE
cd $VIMSOURCE

./configure --with-features=huge \
	--enable-multibyte \
	--enable-rubyinterp=yes \
	--enable-python3interp=yes \
	--with-python3-config-dir=/usr/lib/python3.5/config \
	--enable-perlinterp=yes \
	--enable-cscope \
	--enable-gui \
	--with-x \
	--prefix=/usr/local

make VIMRUNTIMEDIR=$INSTALLDIR
