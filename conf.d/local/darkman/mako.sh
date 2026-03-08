#!/bin/sh

case "$1" in
dark)
  makoctl set-mode dark
  ;;
light)
  makoctl set-mode light
  ;;
esac
