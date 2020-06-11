#!/bin/bash

fancy_echo() {
    local cyan=$(tput setaf 6)
    local yellow=$(tput setaf 3)
    local normal=$(tput sgr0)
    local fmt="$1"; shift

    printf "\n${cyan}~~> ${yellow}$fmt${normal}\n" "$@"
}

export SETUP_DIR=$HOME/.dotfiles.d

sudo true

fancy_echo "Installing packages"
sudo pacman -S --needed --noconfirm - < $SETUP_DIR/setup/manjaro-packages.txt

fancy_echo "Installing AUR packages"
xargs -a $SETUP_DIR/setup/aur.txt pamac build --no-confirm

fancy_echo "Enabling snapd"
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

fancy_echo "Installing Snaps"
xargs -a $SETUP_DIR/setup/snaps.txt sudo snap install
xargs -a $SETUP_DIR/setup/classic_snaps.txt sudo snap install --classic

fancy_echo "Installing Flatpaks"
xargs -a $SETUP_DIR/setup/flatpak.txt sudo flatpak install -y

fancy_echo "Setting up Doom"
sh $SETUP_DIR/setup/doom.sh

fancy_echo "Setting Fish as shell"
sh $SETUP_DIR/setup/fish.sh

fancy_echo "Creating symlinks for dotfiles"
echo "Creating new symlinks"
ls $SETUP_DIR/conf.d | xargs -L 1 -I{} ln -sf $SETUP_DIR/conf.d/{} $HOME/.{}

fancy_echo "Setting up termintaor"
sh $SETUP_DIR/setup/terminator.sh

fancy_echo "Creating quirks-handler for Magic Trackpad 2"
sh $SETUP_DIR/setup/magic-trackpad-quirks.sh

fancy_echo "Creating symlinks for git hooks"
hooks_dir=$(pacman -Qql git | grep -m 1 templates)hooks
ls $SETUP_DIR/git/hooks | xargs -L 1 -I{} sudo ln -sf $SETUP_DIR/git/hooks/{} $hooks_dir/{}

fancy_echo "Configuring GPG and Yubikey"
sh $SETUP_DIR/setup/gpg-and-yubikey.sh

fancy_echo "Setting up caps2esc"
sh $SETUP_DIR/setup/caps2esc.sh

fancy_echo "Done"
