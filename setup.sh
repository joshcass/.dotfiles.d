#!/bin/bash

fancy_echo() {
    local cyan=$(tput setaf 6)
    local yellow=$(tput setaf 3)
    local normal=$(tput sgr0)
    local fmt="$1"; shift

    printf "\n${cyan}~~> ${yellow}$fmt${normal}\n" "$@"
}

dir=~/.dotfiles.d

#### Install packages #####
sudo true

fancy_echo "Adding and installing packages from custom PPA's"
sh $dir/setup/ppas.sh

fancy_echo "Installing packages through apt"
sudo apt-get update
xargs -a $dir/setup/apt-packages.txt sudo apt-get install

fancy_echo "Installing snaps"
xargs -a $dir/setup/snaps.txt sudo snap install

fancy_echo "Installing global NPM packages"
xargs -a $dir/setup/npm-packages.txt sudo npm install -g

fancy_echo "Cloning packages installed via git"
sh $dir/setup/git-clones.sh

#### Make sure ZSH is set as the shell #####
update_shell() {
    local shell_path;
    shell_path="$(which zsh)"

    fancy_echo "Changing shell to zsh"
    if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
        fancy_echo "Adding '$shell_path' to /etc/shells"
        sudo sh -c "echo $shell_path >> /etc/shells"
    fi
    sudo chsh -s "$shell_path" "$USER"
}

case "$SHELL" in
    */zsh)
        if [ "$(which zsh)" != '/usr/bin/zsh' ] ; then
            update_shell
        fi
        ;;
    *)
        update_shell
        ;;
esac

##### Create Links #####
files="rspec pryrc gitconfig gitignore-global jsbeautifyrc vimrc zlogin zshenv zshrc"

fancy_echo "Creating symlinks for dotfiles"

for file in $files; do
    echo "Removing existing .$file"
    rm ~/.$file
    echo "Creating new symlink for .$file"
    ln -s $dir/config/$file ~/.$file
done

##### Import GPG Public Key and link keys to Yubi #####
fancy_echo "Adding/updating GPG key from keybase.io"
curl https://keybase.io/joshcass/key.asc | gpg --import

fancy_echo "Linking GPG keys from Yubikey smartcard"
gpg --card-status

##### Configure GPG Agent for use as SSH Agent #####
fancy_echo "Configring GPG Agent for use as SSH Agent"
sh $dir/setup/gpg-agent-config.sh

##### Clone and install Spacemacs #####
fancy_echo "Cloning Spacemacs"
if [ ! -d ~/.emacs.d ]; then
    echo "Cloning Spacemacs repo into ~/.emacs.d"
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
else
    echo "~/.emacs.d already exists. Not cloning."
fi

fancy_echo "Cloning Spacemacs config"
if [ ! -d ~/.spacemacs.d ]; then
    echo "Cloning .spacemacs.d into ~/.spacemacs.d"
    git clone https://github.com/joshcass/.spacemacs.d.git ~/.spacemacs.d
    touch ~/.spacemacs.d/custom.el
else
    echo "~/.spacemacs.d already exists. Not cloning."
fi

#### Install some useful heroku things ####
fancy_echo "Installing heroku plugins"
heroku plugins:install heroku-accounts

##### Create secrets file #####
fancy_echo "Ensuring secrets file"
touch $dir/secrets

fancy_echo "Done"
