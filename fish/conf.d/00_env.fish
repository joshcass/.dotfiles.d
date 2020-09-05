set -gx DOTFILES $HOME/.dotfiles.d

set -gx EDITOR /usr/bin/emacs

set -gx PATH $HOME/.emacs.d/bin:$HOME/.parity/bin $PATH

set -gx BROWSER /usr/bin/vivaldi-stable

source /opt/asdf-vm/asdf.fish

eval (direnv hook fish)
