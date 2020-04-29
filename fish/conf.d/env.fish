export DOTFILES=$HOME/.dotfiles.d

export EDITOR=/usr/bin/vim

export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

source /usr/share/doc/pkgfile/command-not-found.fish

source /opt/asdf-vm/asdf.fish

eval (direnv hook fish)
