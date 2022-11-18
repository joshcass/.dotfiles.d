#!/bin/bash
# Relevant info comes from here
# https://blog.josefsson.org/2017/06/19/openpgp-smartcard-under-gnome-on-debian-9-0-stretch/

update_gpg_agent() {
    local enable_ssh
    enable_ssh="enable-ssh-support"

    if ! grep "$enable_ssh" $HOME/.gnupg/gpg-agent.conf >/dev/null 2>&1; then
        echo "Adding '$enable_ssh' to gpg-agent.conf"
        sh -c "echo $enable_ssh >> $HOME/.gnupg/gpg-agent.conf"
    else
        echo "'$enable_ssh' already added to gpg-agent.conf"
    fi
}

add_pam_env() {
    cat <<EOF | sudo tee -a /etc/security/pam_env.conf
SSH_AGENT_PID DEFAULT=
SSH_AUTH_SOCK DEFAULT="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
EOF
}

echo "Adding GPG key"
gpg --recv-keys 9ED743C49E12ED4077E26A8BBBF76C7AC21E4CBD

echo "Linking GPG keys from Yubikey smartcard"
gpg --card-status

update_gpg_agent
add_pam_env
