set -gx DOTFILES $HOME/.dotfiles.d

set -gx EDITOR /usr/bin/emacs

set -gx BROWSER /usr/bin/vivaldi-stable

set -gx Z_DATA $HOME/.local/share/zdata

set -gx Z_DATA_DIR $HOME/.local/share/z

set -gx Z_EXCLUDE \x5e$HOME\x24

set -gx VAULT_ADDR https://vault.bonus.ly

source /opt/asdf-vm/asdf.fish

asdf exec direnv hook fish | source
