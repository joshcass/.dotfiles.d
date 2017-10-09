autoload -U compinit && compinit

autoload -Uz $DOTFILES/functions/*(:t)

source $(brew --prefix nvm)/nvm.sh

eval "$(direnv hook zsh)"

eval "$(rbenv init -)"
