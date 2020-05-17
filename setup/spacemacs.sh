clone_spacemacs() {
    if [ ! -d ~/.emacs.d ]; then
        echo "Cloning Spacemacs repo into ~/.emacs.d"
        git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    else
        echo "Spacemacs may already be installed ~/.emacs.d exists."
    fi
}

clone_dot_spacemacs() {
    if [ ! -d ~/.spacemacs.d ]; then
        echo "Cloning .spacemacs.d into ~/.spacemacs.d"
        git clone https://github.com/joshcass/.spacemacs.d.git ~/.spacemacs.d
        touch ~/.spacemacs.d/custom.el
    else
        echo "Spaceamcs config already installed"
    fi
}

clone_spacemacs
clone_dot_spacemacs
