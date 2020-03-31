#!/bin/bash
INSTALL_PATH=/usr/share/fonts/opentype/source-code-pro
[ -d /usr/share/fonts/opentype ] || sudo mkdir -p $INSTALL_PATH
[ -d ./fonts/source-code-pro ] || sudo git clone https://github.com/adobe-fonts/source-code-pro.git
sudo cp -r fonts/source-code-pro/* $INSTALL_PATH
sudo fc-cache -f -v $INSTALL_PATH
