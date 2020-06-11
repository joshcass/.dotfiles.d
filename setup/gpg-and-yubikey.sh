#!/bin/bash
# Relevant info comes from here
# https://blog.josefsson.org/2017/06/19/openpgp-smartcard-under-gnome-on-debian-9-0-stretch/

disable_gnome_keyring_autostart() {
    local hide_gnome_keyring;
    local gnome_keyring_desktop;
    gnome_keyring_desktop="gnome-keyring-ssh.desktop"
    hide_gnome_keyring="Hidden=true"

    if [ ! -d $HOME/.config/autostart ]; then
        echo "Creating ~/.config/autostart"
        mkdir $HOME/.config/autostart
    fi

    if [ ! -f $HOME/.config/autostart/"$gnome_keyring_desktop"  ]; then
        echo "Copying gnome-keyring-ssh.desktop to ~/.config/autostart"
        cp /etc/xdg/autostart/gnome-keyring-ssh.desktop $HOME/.config/autostart/
    fi

    if ! grep "$hide_gnome_keyring" $HOME/.config/autostart/"$gnome_keyring_desktop" > /dev/null 2>&1; then
        echo "Disabling gnome-keyring-ssh autostart"
        sh -c "echo $hide_gnome_keyring >> ~/.config/autostart/gnome-keyring-ssh.desktop"
    else
        echo "gnome-keyring-ssh already disabled"
    fi
}

update_gpg_agent() {
    local enable_ssh;
    enable_ssh="enable-ssh-support"

    if ! grep "$enable_ssh" $HOME/.gnupg/gpg-agent.conf > /dev/null 2>&1; then
        echo "Adding '$enable_ssh' to gpg-agent.conf"
        sh -c "echo $enable_ssh >> $HOME/.gnupg/gpg-agent.conf"
    else
        echo "'$enable_ssh' already added to gpg-agent.conf"
    fi
}

echo "Adding/updating GPG key from keybase.io"
curl https://keybase.io/joshcass/key.asc | gpg --import

echo "Linking GPG keys from Yubikey smartcard"
gpg --card-status

disable_gnome_keyring_autostart
update_gpg_agent
