#!/bin/bash

cd "$HOME/Installs"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
