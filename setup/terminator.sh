#!/bin/bash

echo "Ensuring directories exist"
mkdir -p $HOME/.config/gtk-3.0
mkdir -p $HOME/.config/terminator

echo "Removing existing links or files"
rm $HOME/.config/terminator/config
rm $HOME/.config/gtk-3.0/gtk.css

echo "Creating new symlinks"
ln -s $SETUP_DIR/terminator/gtk.css $HOME/.config/gtk-3.0/gtk.css
ln -s $SETUP_DIR/terminator/config $HOME/.config/terminator/config
