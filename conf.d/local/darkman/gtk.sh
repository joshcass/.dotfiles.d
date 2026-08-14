#!/bin/sh

case "$1" in
dark)
  gsettings set org.gnome.desktop.interface gtk-theme nordic
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  ;;
light)
  gsettings set org.gnome.desktop.interface gtk-theme nordic-polar
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  ;;
esac
