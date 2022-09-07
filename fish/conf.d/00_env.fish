set -gx DOTFILES $HOME/.dotfiles.d

set -gx EDITOR /usr/bin/emacs

set -gx BROWSER /usr/bin/vivaldi-stable

set -gx Z_DATA $HOME/.local/share/zdata

set -gx Z_DATA_DIR $HOME/.local/share/z

set -gx Z_EXCLUDE \x5e$HOME\x24

set -gx VAULT_ADDR https://vault.bonus.ly

set fish_function_path $HOME/.config/fish/functions/pure/functions $fish_function_path

set fish_function_path $HOME/.config/fish/functions/z/functions $fish_function_path

fish_add_path $HOME/.emacs.d/bin

fish_add_path $HOME/.dotfiles.d/i3/scripts

source /opt/asdf-vm/asdf.fish
