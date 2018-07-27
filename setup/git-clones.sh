clone_nvm() {
    if [ ! -d ~/.nvm ]; then
        echo "Cloning NVM"
        git clone https://github.com/creationix/nvm.git ~/.nvm
        echo "Installing Node stable"
        source ~/.nvm/nvm.sh
        nvm install stable
    else
        echo "NVM installed"
    fi
}

clone_dokku() {
    if [ ! -d ~/.dokku ]; then
        echo "Cloning Dokku"
        git clone https://github.com/dokku/dokku.git ~/.dokku
    else
        echo "Dokku installed"
    fi
}

clone_nvm
clone_dokku
