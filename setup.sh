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

fancy_echo "Cloning dotfiles repo"
git clone https://github.com/joshcass/.dotfiles.d.git "$SETUP_DIR"

fancy_echo "Installing package groups"
sudo pacman -S --needed base-devel
sudo pacman -S --needed i3

fancy_echo "Installing packages"
sudo pacman -S --needed --noconfirm - <$SETUP_DIR/setup.d/packages.txt

fancy_echo "Installing paru"
sh $SETUP_DIR/setup.d/paru.sh

fancy_echo "Install aur packages"
paru -S --noconfirm - <$SETUP_DIR/setupd.d/aur.txt

fancy_echo "Updating pkgfile"
sudo pkgfile -u

fancy_echo "Setting up Doom"
sh $SETUP_DIR/setup.d/doom.sh

fancy_echo "Setting Fish as shell"
sh $SETUP_DIR/setup.d/fish.sh

fancy_echo "Creating symlinks for dotfiles"
echo "Creating new symlinks"
ls $SETUP_DIR/conf.d/home | xargs -L 1 -I{} ln -sf $SETUP_DIR/conf.d/home/{} $HOME/.{}

fancy_echo "Creating symlinks for config files"
ls $SETUP_DIR/conf.d/config | xargs -L 1 -I{} ln -sf $SETUP_DIR/conf.d/config/{} $HOME/.config/{}

fancy_echo "Enabling natural scroll"
sudo sed -i '/EndSection/ i \    Option "NaturalScrolling" "true"' /etc/X11/xorg.conf.d/30-touchpad.conf

fancy_echo "Configuring GPG and Yubikey"
# need to enable pcscd.socket too
sh $SETUP_DIR/setup.d/gpg-and-yubikey.sh

fancy_echo "Enabling redshift"
systemctl --user enable redshift

fancy_echo "Symlinking i3 config"
rm -rf $HOME/.config/i3
rm -rf $HOME/.config/i3status
ln -sf $SETUP_DIR/i3 $HOME/.config/i3
ln -sf $SETUP_DIR/i3status $HOME/.config/i3status

fancy_echo "Symlinking alacritty config"
rm -rf $HOME/.config/alacritty
ln -sf $SETUP_DIR/alacritty $HOME/.config/alacritty

fancy_echo "Cloning submodules"
git submodule init
git submoudle update --remote

fancy_echo "Linking themes"
sudo ln -sf $SETUP_DIR/theming/Nordic /usr/share/themes/nordic
sudo ln -sf $SETUP_DIR/theming/Nordic/kde/sddm/Nordic-darker /usr/share/sddm/themes/nordic
cat <<EOF | sudo tee -a /etc/sddm.conf.d/theme.conf
[Theme]
Current=nordic
EOF

fancy_echo "Done."

read -p 'Reboot now ? [y/N]' reboot

if [ "$reboot" = "y" ] || [ "$reboot" = "Y" ]; then
	sudo shutdown -r now
else
	printf "\n"
	exit 0
fi
