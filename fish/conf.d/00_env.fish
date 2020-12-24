set -gx DOTFILES $HOME/.dotfiles.d

set -gx EDITOR /usr/bin/emacs

set -gx PATH $HOME/.emacs.d/bin:$HOME/.parity/bin $PATH

set -gx BROWSER /usr/bin/vivaldi-snapshot

set -gx Z_DATA $HOME/.local/share/zdata

set -gx Z_DATA_DIR $HOME/.local/share/z

set -gx Z_EXCLUDE \x5e$HOME\x24

source /opt/asdf-vm/asdf.fish

eval (direnv hook fish)
