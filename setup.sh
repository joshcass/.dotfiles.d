#!/bin/bash

fancy_echo() {
    local cyan=$(tput setaf 6)
    local yellow=$(tput setaf 3)
    local normal=$(tput sgr0)
    local fmt="$1"; shift

    printf "\n${cyan}~~> ${yellow}$fmt${normal}\n" "$@"
}

dir=~/.dotfiles.d

##### Install Xcode CLT if not already #####
if [ ! -x "$(command -v xcode-select)" ]; then
    fancy_echo "Installing Xcode CLT"
    xcode-select --install
fi

##### Install homebrew if not already #####
if [ ! -x "$(command -v brew)" ]; then
    fancy_echo "Installng Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

##### Install deps with brew ####
cd $dir
fancy_echo "Updating Homebrew"
brew update
fancy_echo "Bundling Brewfile"
brew tap homebrew/bundle
brew bundle
fancy_echo "Cleaning up Homebrew"
brew cleanup

#### Make sure ZSH is set as the shell #####
update_shell() {
    local shell_path;
    shell_path="$(which zsh)"

    fancy_echo "Changing shell to zsh"
    if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
        fancy_echo "Adding '$shell_path' to /etc/shells"
        sudo sh -c "echo $shell_path >> /etc/shells"
    fi
    sudo chsh -s "$shell_path" "$USER"
}

case "$SHELL" in
    */zsh)
        if [ "$(which zsh)" != '/usr/local/bin/zsh' ] ; then
            update_shell
        fi
        ;;
    *)
        update_shell
        ;;
esac

##### Create Links #####
files="rspec pryrc gitconfig gitignore-global jsbeautifyrc vimrc zlogin zshenv zshrc"

fancy_echo "Creating symlinks for dotfiles"

for file in $files; do
    echo "Removing existing .$file"
    rm ~/.$file
    echo "Creating new symlink for .$file"
    ln -s $dir/config/$file ~/.$file
done

fancy_echo "Creating symlink for iCloud"
ln -s ~/Library/Mobile Documents/com~apple~CloudDocs ~/iCloud

##### Copy GPG-Agent #####
fancy_echo "Copying GPG Agent conf"

cp $dir/config/gpg-agent.conf ~/.gnupg

##### Import GPG Public Key and link keys to Yubi #####
fancy_echo "Adding/updating GPG key from keybase.io"
curl https://keybase.io/joshcass/key.asc | gpg --import

fancy_echo "Linking GPG keys from Yubikey smartcard"
gpg --card-status

##### Clone and install Spacemacs #####
if [ ! -d ~/.emacs.d ]; then
    fancy_echo "Cloning Spacemacs repo into ~/.emacs.d"
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
else
    fancy_echo "~/.emacs.d already exists. Not cloning."
fi

if [ ! -d ~/.spacemacs.d ]; then
    fancy_echo "Cloning .spacemacs.d into ~/.spacemacs.d"
    git clone https://github.com/joshcass/.spacemacs.d.git ~/.spacemacs.d
else
    fancy_echo "~/.spacemacs.d already exists. Not cloning."
fi

#### Install some useful heroku things ####
if [ ! "heroku accounts" ]; then
    fancy_echo "Installing heroku plugins"
    heroku plugins:install heroku-accounts
fi

##### Create secrets file #####
fancy_echo "Ensuring secrets file"
touch $dir/secrets

fancy_echo "Done"
