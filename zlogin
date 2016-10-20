autoload -U compinit && compinit

source $(brew --prefix nvm)/nvm.sh

eval "$(direnv hook zsh)"

eval "$(rbenv init -)"
