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
sudo pacman -S --needed --noconfirm - < $SETUP_DIR/setup/packages.txt

fancy_echo "Installing AUR packages"
xargs -a $SETUP_DIR/setup/aur.txt pamac build --no-confirm

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

fancy_echo "Enabling natural scroll"
sudo sed -i '/EndSection/ i \    Option "NaturalScrolling" "true"' /etc/X11/xorg.conf.d/30-touchpad.conf

fancy_echo "Creating symlinks for git hooks"
hooks_dir=$(pacman -Qql git | grep -m 1 templates)hooks
ls $SETUP_DIR/git/hooks | xargs -L 1 -I{} sudo ln -sf $SETUP_DIR/git/hooks/{} $hooks_dir/{}

fancy_echo "Configuring GPG and Yubikey"
sh $SETUP_DIR/setup/gpg-and-yubikey.sh

fancy_echo "Setting up keyboard"
localectl us,us pc105, norman, ctrl:nocaps,grp:win_space_toggle

fancy_echo "Installing suspend unit"
sudo cp $SETUP_DIR/setup/suspend_unit.txt /etc/systemd/system/suspend@.service
sudo systemctl enable suspend@$USER

fancy_echo "Done"
