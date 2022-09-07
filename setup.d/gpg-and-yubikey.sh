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
    if [ ! -f $HOME/.pam_environment ]; then
        echo "Creating ~/.pam_environment"
        echo | tee $HOME/.pam_environment <<END_TEXT
SSH_AGENT_PID	DEFAULT=
SSH_AUTH_SOCK	DEFAULT="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
END_TEXT
    else
        echo ".pam_environmnt already created"
    fi
}

echo "Adding/updating GPG key from keybase.io"
curl https://keybase.io/joshcass/key.asc | gpg --import

echo "Linking GPG keys from Yubikey smartcard"
gpg --card-status

disable_gnome_keyring_autostart
update_gpg_agent
add_pam_env
