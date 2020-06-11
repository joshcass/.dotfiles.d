clone_doom() {
    if [ ! -d $HOME/.emacs.d ]; then
        echo "Cloning Doom repo into ~/.emacs.d"
        git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
        $HOME/.emacs.d/bin/doom install
    else
        echo "Doom may already be installed ~/.emacs.d exists."
    fi
}

symlink_doom_config() {
    if [ ! -d $HOME/.doom.d ]; then
        echo "Symlinking .doom.d into ~/.doom.d"
        ln -s $SETUP_DIR/doom.d $HOME/.doom.d
    else
        echo "Doom config already installed"
    fi
}

clone_doom
symlink_doom_config
