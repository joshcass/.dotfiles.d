export DOTFILES=~/.dotfiles.d

export NVM_DIR=~/.nvm

export GOPATH=~/.go_path

export EDITOR=/usr/bin/vim

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
  export SSH_AGENT_PID
fi

GPG_TTY=$(tty)
export GPG_TTY
