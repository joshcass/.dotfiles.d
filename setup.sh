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

fancy_echo "Installing packages"
sudo pacman -S --needed --noconfirm - <$SETUP_DIR/setup.d/packages.txt

fancy_echo "Installing yay"
sh $SETUP_DIR/setup.d/yay.sh

fancy_echo "Install aur packages"
yay -S --noconfirm - <$SETUP_DIR/setup.d/aur.txt

fancy_echo "Updating pkgfile"
sudo pkgfile -u

fancy_echo "Updating xdg user dirs"
xdg-user-dirs-update

fancy_echo "Installing nix"
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

fancy_echo "Installing devbox"
curl -fsSL https://get.jetpack.io/devbox | bash

fancy_echo "Setting Fish as shell"
sh $SETUP_DIR/setup.d/fish.sh

fancy_echo "Creating symlinks for dotfiles"
for item in $SETUP_DIR/conf.d/home/*; do
  ln -sfn "$item" "$HOME/.$(basename "$item")"
done

fancy_echo "Creating symlinks for config files"
for item in $SETUP_DIR/conf.d/config/*; do
  ln -sfn "$item" "$HOME/.config/$(basename "$item")"
done

fancy_echo "Configuring GPG and Yubikey"
sh $SETUP_DIR/setup.d/gpg-and-yubikey.sh

fancy_echo "Enabling systemd units"
systemctl --user daemon-reload
systemctl --user enable darkman.service
systemctl enable bluetooth.service
systemctl enable reflector.service
systemctl enable cups.service

fancy_echo "Cloning submodules"
(
  cd "$SETUP_DIR"
  git submodule init
  git submodule update --remote
)

fancy_echo "Linking themes"
sudo mkdir -p /usr/share/themes
sudo ln -sfn $SETUP_DIR/theming/Nordic /usr/share/themes/nordic
sudo ln -sfn $SETUP_DIR/theming/Nordic-Polar /usr/share/themes/nordic-polar

fancy_echo "Update repo remote to use SSH "
git remote set-url origin git@github.com:joshcass/.dotfiles.d.git

fancy_echo "Done."

read -p 'Reboot now ? [y/N]' reboot

if [ "$reboot" = "y" ] || [ "$reboot" = "Y" ]; then
  sudo shutdown -r now
else
  printf "\n"
  exit 0
fi
