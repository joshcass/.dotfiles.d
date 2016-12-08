autoload -U compinit && compinit

source $(brew --prefix nvm)/nvm.sh

eval "$(direnv hook zsh)"

eval "$(rbenv init -)"

fpath=($DOTFILES/functions $fpath)

autoload -Uz $DOTFILES/functions/*(:t)
