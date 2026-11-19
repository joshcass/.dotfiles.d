#!/bin/sh

case "$1" in
dark)
  makoctl mode -s dark
  ;;
light)
  makoctl mode -s light
  ;;
esac
