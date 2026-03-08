#!/bin/sh

case "$1" in
dark)
  gsettings set org.gnome.desktop.interface gtk-theme nordic
  ;;
light)
  gsettings set org.gnome.desktop.interface gtk-theme nordic-polar
  ;;
esac
