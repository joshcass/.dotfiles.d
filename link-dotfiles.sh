#!/bin/bash

###### Variables ######

dir=~/.dotfiles.d
files="rspec git-scripts gitconfig gitignore-global jsbeautifyrc vimrc zlogin zshenv zshrc"

##### Create Links #####

for file in $files; do
    echo "Creating symlink for $file in home directory"
    ln -s $dir/$file ~/.$file
done

echo "Done"
