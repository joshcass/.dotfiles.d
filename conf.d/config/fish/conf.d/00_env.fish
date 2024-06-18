set -gx DOTFILES $HOME/.dotfiles.d

set -gx EDITOR /usr/bin/neovide

set -gx BROWSER /usr/bin/chromium

set -gx Z_DATA $HOME/.local/share/zdata

set -gx Z_DATA_DIR $HOME/.local/share/z

set -gx Z_EXCLUDE \x5e$HOME\x24

set -gx VAULT_ADDR https://vault.bonus.ly

set -gx GPG_TTY (tty)

set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set fish_function_path $HOME/.config/fish/functions/pure/functions $fish_function_path

set fish_function_path $HOME/.config/fish/functions/z/functions $fish_function_path

fish_add_path $HOME/.dotfiles.d/scripts.d

direnv hook fish | source
