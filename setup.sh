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
xargs -L 1 -a $dir/setup/apt-packages.txt sudo apt-get install -y

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
echo "Removing existing symlinks"
ls $dir/config | xargs -L 1 -I{} rm ~/.{}

echo "Creating new symlinks"
ls $dir/config | xargs -L 1 -I{} ln -s $dir/config/{} ~/.{}

fancty_echo "Creating symlinks for termintaor"
echo "Ensuring directories exist"
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/terminator

echo "Removing existing links or files"
rm ~/.config/terminator/config
rm ~/.config/gtk-3.0/gtk.css

echo "Creating new symlinks"
ln -s $dir/terminator/gtk.css ~/.config/gtk-3.0/gtk.css
ln -s $dir/terminator/config ~/.config/terminator/config

fancy_echo "Creating symlinks for git hooks"
hooks_dir=$(dpkg -L git | grep -m 1 templates)/hooks
ls $dir/git_hooks | xargs -L 1 -I{} sudo ln -s $dir/git_hooks/{} $hooks_dir/{}

fancy_echo "Configuring GPG and Yubikey"
sh $dir/setup/gpg-and-yubikey.sh

fancy_echo "Installing heroku plugins"
xargs -a $dir/setup/heroku-plugins.txt heroku plugins:install

fancy_echo "Ensuring secrets file"
touch $dir/secrets

fancy_echo "Done"
