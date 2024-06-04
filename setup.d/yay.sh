#!/bin/bash

install_yay() {
    if [ ! -x "$(command -v yay)" ]; then
        echo "cloning"
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        echo "compiling"
        cd /tmp/yay
        makepkg -si
    else
        echo "yay is already installed"
    fi
}

install_yay
