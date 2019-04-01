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

install_yarn() {
    if [ ! -x "$(command -v yarn)" ]; then
        wget -qO https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt update
        sudo apt install yarn -y
    else
        echo "Yarn already installed"
    fi
}

install_chrome() {
    if [ ! -x "$(command -v google-chrome)" ]; then
        wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
        sudo apt update
        sudo apt intsall google-chrome-stable -y
    else
        echo "Google Chrome already installed"
    fi
}

install_parity
install_keybase
install_yarn
install_chrome
