export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home"
export PATH=$JAVA_HOME/bin:$PATH

export NVM_DIR=~/.nvm

export GOPATH=~/.go_path

export EDITOR=/usr/bin/vim

source ~/.dotfiles.d/secrets

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
  export SSH_AGENT_PID
fi

GPG_TTY=$(tty)
export GPG_TTY
