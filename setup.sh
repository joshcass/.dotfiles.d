#!/bin/bash

fancy_echo() {
	local cyan=$(tput setaf 6)
	local yellow=$(tput setaf 3)
	local normal=$(tput sgr0)
	local fmt="$1"
	shift

	printf "\n${cyan}~~> ${yellow}$fmt${normal}\n" "$@"
}

export SETUP_DIR=$HOME/.dotfiles.d

sudo true

fancy_echo "Installing packages"
sudo pacman -S --needed --noconfirm - <$SETUP_DIR/setup.d/packages.txt

fancy_echo "Installing AUR packages"
xargs -a $SETUP_DIR/setup.d/aur.txt pamac build --no-confirm

fancy_echo "Updating pkgfile"
sudo pkgfile -u

fancy_echo "Setting up Doom"
sh $SETUP_DIR/setup.d/doom.sh

fancy_echo "Setting Fish as shell"
sh $SETUP_DIR/setup.d/fish.sh

fancy_echo "Creating symlinks for dotfiles"
echo "Creating new symlinks"
ls $SETUP_DIR/conf.d/home | xargs -L 1 -I{} ln -sf $SETUP_DIR/conf.d/home/{} $HOME/.{}

fancy_echo "Creating symlings for config files"
ls $SETUP_DIR/conf.d/config | xargs -L 1 -I{} ln -sf $SETUP_DIR/conf.d/config/{} $HOME/.config/{}

fancy_echo "Setting up termintaor"
sh $SETUP_DIR/setup.d/terminator.sh

fancy_echo "Enabling natural scroll"
sudo sed -i '/EndSection/ i \    Option "NaturalScrolling" "true"' /etc/X11/xorg.conf.d/30-touchpad.conf

fancy_echo "Creating symlinks for git hooks"
hooks_dir=$(pacman -Qql git | grep -m 1 templates)hooks
ls $SETUP_DIR/git/hooks | xargs -L 1 -I{} sudo ln -sf $SETUP_DIR/git/hooks/{} $hooks_dir/{}

fancy_echo "Configuring GPG and Yubikey"
# need to enable pcscd.socket too
sh $SETUP_DIR/setup.d/gpg-and-yubikey.sh

fancy_echo "Enabling redshift"
systemctl --user enable redshift

fancy_echo "Symlinking i3 config"
rm -rf $HOME/.i3
rm -rf $HOME/.config/i3status
ln -sf $SETUP_DIR/i3 $HOME/.i3
ln -sf $SETUP_DIR/i3status $HOME/.config/i3status

fancy_echo "Done."

read -p 'Reboot now ? [y/N]' reboot

if [ "$reboot" = "y" ] || [ "$reboot" = "Y" ]; then
	sudo shutdown -r now
else
	printf "\n"
	exit 0
fi
