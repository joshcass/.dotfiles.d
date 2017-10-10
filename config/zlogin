autoload -U compinit && compinit

autoload -Uz $DOTFILES/functions/*(:t)

source $(brew --prefix nvm)/nvm.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $DOTFILES/secrets

eval "$(direnv hook zsh)"

eval "$(rbenv init -)"

path+=$DOTFILES/scripts/bash

fpath=($DOTFILES/functions $fpath)
