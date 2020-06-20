#!/bin/bash

clone_doom() {
    if [ ! -d $HOME/.emacs.d ]; then
        echo "Cloning Doom repo into ~/.emacs.d"
        git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
        echo "Installing doom"
        $HOME/.emacs.d/bin/doom install
    else
        echo "Doom may already be installed ~/.emacs.d exists."
    fi
}

echo "Symlinking .doom.d into ~/.doom.d"
ln -sf $SETUP_DIR/doom.d $HOME/.doom.d
clone_doom
