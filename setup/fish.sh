#!/bin/bash
 
update_shell() {
    local shell_path="$(which fish)"

    echo "Changing shell to fish"
    if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
        echo "Adding '$shell_path' to /etc/shells"
        sudo sh -c "echo $shell_path >> /etc/shells"
    fi
    sudo chsh -s "$shell_path" "$USER"
}

symlink_doom_config() {
    if [ ! -d $HOME/.config/fish ]; then
        echo "Symlinking ~/.config/fish"
        ln -s $SETUP_DIR/fish $HOME/.config/fish
    else
        echo "Fish config already installed"
    fi
}

case "$SHELL" in
    */fish)
        if [ "$(which fish)" != '/usr/bin/fish' ] ; then
            update_shell
        else
            echo "Fish is already configured"
        fi
        ;;
    *)
        update_shell
        ;;
esac
