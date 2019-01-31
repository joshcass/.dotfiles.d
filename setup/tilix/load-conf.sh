symlink_vte() {
    if [ ! -e /etc/profile.d/vte.sh ]; then
        echo "Symlinking vte.sh"
        sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
    else
        echo "vte.sh already symlinked"
    fi
}
symlink_vte

echo 'Loading tilix config'
dconf load /com/gexperts/Tilix/ < $DOTFILES/setup/tilix/tilix.dconf
