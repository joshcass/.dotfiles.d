set -gx DOTFILES $HOME/.dotfiles.d

set -gx PATH $HOME/.emacs.d/bin:$HOME/.parity-3.2.0/bin $PATH

source /usr/share/doc/pkgfile/command-not-found.fish

source /opt/asdf-vm/asdf.fish

eval (direnv hook fish)
