#!/bin/bash

###### Variables ######

dir=~/.dotfiles.d
files="rspec pryrc gitconfig gitignore-global jsbeautifyrc vimrc zlogin zshenv zshrc"

##### Install deps with brew ####
brew update
brew tap homebrew/bundle
brew bundle
brew cleanup

##### Create Links #####

for file in $files; do
    echo "Creating symlink for $file in home directory"
    ln -s $dir/$file ~/.$file
done

##### Create secrets file #####

touch $dir/secrets

#### Install some useful heroku things ####

heroku plugins:install heroku-accounts

echo "Done"
