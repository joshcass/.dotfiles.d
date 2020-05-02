#!/bin/bash

fancy_echo() {
    local cyan=$(tput setaf 6)
    local yellow=$(tput setaf 3)
    local normal=$(tput sgr0)
    local fmt="$1"; shift

    printf "\n${cyan}~~> ${yellow}$fmt${normal}\n" "$@"
}

dir=~/.dotfiles.d

sudo true

fancy_echo "Adding and installing packages from custom PPA's"
sh $dir/setup/ppas.sh

fancy_echo "Installing packages via Apt"
sudo apt-get update
xargs -a $dir/setup/apt-packages.txt sudo apt-get install -y

fancy_echo "Installing Snaps"
xargs -a $dir/setup/snaps.txt sudo snap install
xargs -L 1 -a $dir/setup/classic-snaps.txt sudo snap install --classic

fancy_echo "Installing global NPM packages"
xargs -a $dir/setup/npm-packages.txt sudo npm install -g

fancy_echo "Cloning packages installed via Git"
sh $dir/setup/git-clones.sh

fancy_echo "Setting Zsh as shell"
sh $dir/setup/update-shell.sh

fancy_echo "Creating symlinks for dotfiles"
echo "Creating new symlinks"
command ls $dir/conf.d | xargs -L 1 -I{} ln -sf $dir/conf.d/{} ~/.{}

fancy_echo "Setting up termintaor"
sh $dir/setup/terminator.sh

fancy_echo "Creating quirks-handler for Magic Trackpad 2"
sh $dir/setup/magic-trackpad-quirks.sh

fancy_echo "Creating symlinks for git hooks"
hooks_dir=$(pacman -Qql git | grep -m 1 templates)hooks
command ls $dir/git/hooks | xargs -L 1 -I{} sudo ln -sf $dir/git/hooks/{} $hooks_dir/{}

fancy_echo "Configuring GPG and Yubikey"
sh $dir/setup/gpg-and-yubikey.sh

fancy_echo "Installing heroku plugins"
xargs -a $dir/setup/heroku-plugins.txt heroku plugins:install

fancy_echo "Ensuring secrets file"
touch $dir/secrets

fancy_echo "Done"
