#!/bin/bash

install_paru() {
    if [ ! -x "$(command -v paru)" ]; then
        echo "cloning"
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        echo "compiling"
        cd /tmp/paru
        makepkg -si
    else
        echo "paru is already installed"
    fi
}

install_paru
