#! /bin/bash

#dwm, dirty auto-installer
cd ~/.config/ && git clone https://github.com/s1m0x/dwm && cd dwm
sudo apt install make build-essential libx11-dev libxinerama-dev sharutils suckless-tools libxft-dev && \
sudo cp ~/.config/dwm_helpers/dwm.desktop /usr/share/xsessions/ && \
sudo cp ~/.config/dwm_helpers/fontawesome-webfont.ttf /usr/local/share/fonts/ && sudo fc-cache -v

