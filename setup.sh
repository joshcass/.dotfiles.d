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
paru -S --noconfirm - <$SETUP_DIR/setup.d/aur.txt

fancy_echo "Updating pkgfile"
sudo pkgfile -u

fancy_echo "Installing nix"
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

fancy_echo "Installing devbox"
curl -fsSL https://get.jetpack.io/devbox | bash

fancy_echo "Setting Fish as shell"
sh $SETUP_DIR/setup.d/fish.sh

fancy_echo "Creating symlinks for dotfiles"
echo "Creating new symlinks"
ls $SETUP_DIR/conf.d/home | xargs -L 1 -I{} ln -sf $SETUP_DIR/conf.d/home/{} $HOME/.{}

fancy_echo "Creating symlinks for config files"
ls $SETUP_DIR/conf.d/config | xargs -L 1 -I{} ln -sf $SETUP_DIR/conf.d/config/{} $HOME/.config/{}

fancy_echo "Configuring GPG and Yubikey"
# need to enable pcscd.socket too
sh $SETUP_DIR/setup.d/gpg-and-yubikey.sh

fancy_echo "Enabling systemd units"
systemctl --user enable gammastep
systemctl --user enable pulseaudio

fancy_echo "Cloning submodules"
(
  cd "$SETUP_DIR"
  git submodule init
  git submodule update --remote
)

fancy_echo "Linking themes"
sudo mkdir -p /usr/share/themes
sudo ln -sf $SETUP_DIR/theming/Nordic /usr/share/themes/nordic
sudo ln -sf $SETUP_DIR/theming/Nordic-Polar /usr/share/themes/nordic-polar

fancy_echo "Done."

read -p 'Reboot now ? [y/N]' reboot

if [ "$reboot" = "y" ] || [ "$reboot" = "Y" ]; then
  sudo shutdown -r now
else
  printf "\n"
  exit 0
fi
