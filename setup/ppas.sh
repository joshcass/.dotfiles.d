install_parity() {
    if ! dpkg --get-selections | grep parity > /dev/null 2>&1; then
        echo "Installing Thoughtbot Parity"
        wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
        echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
        sudo apt-get update
        sudo apt-get install parity -y
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
        sudo apt-get update
        sudo apt-get install yarn -y
    else
        echo "Yarn already installed"
    fi
}

install_chrome() {
    if [ ! -x "$(command -v google-chrome)" ]; then
        wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
        sudo apt-get update
        sudo apt-get install google-chrome-stable -y
    else
        echo "Google Chrome already installed"
    fi
}

install_insync() {
    if [ ! -x "$(command -v insync)" ]; then
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
        echo deb http://apt.insynchq.com/ubuntu "$(lsb_release -cs)" non-free contrib | sudo tee /etc/apt/sources.list.d/insync.list
        sudo apt-get update
        sudo apt-get install insync -y
    else
        echo "Insync already installed"
    fi
}

install_brave() {
    if [ ! -x "$(command -v brave-browser)" ]; then
        curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key add -
        echo deb https://brave-browser-apt-release.s3.brave.com "$(lsb_release -cs)" main | sudo tee /etc/apt/sources.list.d/brave.list
        sudo apt-get update
        sudo apt-get install brave-browser -y
    else
        echo "Brave browser already installed"
    fi
}

install_parity
install_keybase
install_yarn
install_chrome
install_insync
install_brave
