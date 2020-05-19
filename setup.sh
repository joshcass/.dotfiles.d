#!/bin/bash

fancy_echo() {
    local cyan=$(tput setaf 6)
    local yellow=$(tput setaf 3)
    local normal=$(tput sgr0)
    local fmt="$1"; shift

    printf "\n${cyan}~~> ${yellow}$fmt${normal}\n" "$@"
}

dir=$HOME/.dotfiles.d

sudo true

fancy_echo "Installing packages"
sudo pacman -S --needed --noconfirm - < $dir/setup/manjaro-packages.txt

fancy_echo "Installing AUR packages"
xargs -a $dir/setup/aur.txt pamac build --no-confirm

fancy_echo "Enabling snapd"
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

fancy_echo "Installing Snaps"
xargs -a $dir/setup/snaps.txt sudo snap install
xargs -a $dir/setup/classic_snaps.txt sudo snap install --classic

fancy_echo "Installing Flatpaks"
xargs -a $dir/setup/flatpak.txt sudo flatpak install -y

fancy_echo "Setting up Doom"
sh $dir/setup/doom.sh

fancy_echo "Setting Fish as shell"
sh $dir/setup/update-shell.sh

fancy_echo "Creating symlinks for dotfiles"
echo "Creating new symlinks"
command ls $dir/conf.d | xargs -L 1 -I{} ln -sf $dir/conf.d/{} $HOME/.{}

fancy_echo "Setting up termintaor"
sh $dir/setup/terminator.sh

fancy_echo "Creating quirks-handler for Magic Trackpad 2"
sh $dir/setup/magic-trackpad-quirks.sh

fancy_echo "Creating symlinks for git hooks"
hooks_dir=$(pacman -Qql git | grep -m 1 templates)hooks
command ls $dir/git/hooks | xargs -L 1 -I{} sudo ln -sf $dir/git/hooks/{} $hooks_dir/{}

fancy_echo "Configuring GPG and Yubikey"
sh $dir/setup/gpg-and-yubikey.sh

fancy_echo "Setting up caps2esc"
sh $dir/setup/caps2esc.sh

fancy_echo "Done"
