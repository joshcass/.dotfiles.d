set -gx DOTFILES $HOME/.dotfiles.d

source /usr/share/doc/pkgfile/command-not-found.fish

source /opt/asdf-vm/asdf.fish

eval (direnv hook fish)
