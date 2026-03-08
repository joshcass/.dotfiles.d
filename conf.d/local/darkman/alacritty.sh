#!/bin/sh

case "$1" in
dark)
  sed -i -e "s/solarized_light/solarized_dark/" $HOME/.config/alacritty/alacritty.toml
  ;;
light)
  sed -i -e "s/solarized_dark/solarized_light/" $HOME/.config/alacritty/alacritty.toml
  ;;
esac
