install_parity() {
    if ! dpkg --get-selections | grep parity > /dev/null 2>&1; then
        echo "Installing Thoughtbot Parity"
        wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
        echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
        sudo apt update
        sudo apt install parity -y
    else
        echo "Thoughbot Parity already installed"
    fi
}

install_keybase() {
    if [ ! -x "$(command -v keybase)" ]; then
        echo "Installing Keybase"
        curl -O https://prerelease.keybase.io/keybase_amd64.deb
        sudo dpkg -i keybase_amd64.deb
        sudo apt-get install -f
        rm keybase_amd64.deb
        run_keybase
    else
        echo "Keybase already installed"
    fi
}

install_parity
install_keybase
