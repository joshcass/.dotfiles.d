#!/bin/bash
# macOS (work laptop) setup: AeroSpace + Karabiner + SketchyBar, the sway-like setup.
# setup.sh is the Arch bootstrap on main; this lives only on work-laptop.
# Assumes Homebrew is installed. Safe to re-run.

fancy_echo() {
  local cyan=$(tput setaf 6)
  local yellow=$(tput setaf 3)
  local normal=$(tput sgr0)
  local fmt="$1"
  shift

  printf "\n${cyan}~~> ${yellow}$fmt${normal}\n" "$@"
}

export SETUP_DIR=$HOME/.dotfiles.d

if ! command -v brew >/dev/null; then
  echo "Homebrew not found. Install it first: https://brew.sh"
  exit 1
fi

if [ ! -d "$SETUP_DIR" ]; then
  fancy_echo "Cloning dotfiles repo"
  git clone -b work-laptop https://github.com/joshcass/.dotfiles.d.git "$SETUP_DIR"
fi

fancy_echo "Trusting third-party taps (AeroSpace, SketchyBar)"
brew tap nikitabobko/tap
brew tap FelixKratz/formulae
brew trust --cask nikitabobko/tap/aerospace
brew trust --formula felixkratz/formulae/sketchybar

fancy_echo "Installing window manager, keyboard remapping, bar and font"
brew install --cask aerospace karabiner-elements font-hack-nerd-font
brew install sketchybar

fancy_echo "Creating symlinks for config files"
mkdir -p "$HOME/.config"
for item in "$SETUP_DIR"/conf.d/config/*; do
  ln -sfn "$item" "$HOME/.config/$(basename "$item")"
done

fancy_echo "Starting SketchyBar at login"
brew services start sketchybar

fancy_echo "Hiding the Dock (auto-hide with a very long delay)"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 1000
killall Dock

fancy_echo "Done. Manual steps left:"
cat <<'EOF'
  1. Open AeroSpace and Karabiner-Elements; grant Accessibility / Input Monitoring
     permissions when asked. AeroSpace starts at login after that (start-at-login).
  2. System Settings: set "Automatically hide and show the menu bar" to Always.
  3. Install Amphetamine from the App Store. The first time you click the
     Amphetamine item in SketchyBar, allow SketchyBar to control Amphetamine.
  4. Keep macOS on a single desktop (Mission Control) and don't bind
     Cmd+F-keys in System Settings > Keyboard Shortcuts; AeroSpace uses them.
EOF
