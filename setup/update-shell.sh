update_shell() {
    local shell_path;
    shell_path="$(which zsh)"

    echo "Changing shell to zsh"
    if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
        echo "Adding '$shell_path' to /etc/shells"
        sudo sh -c "echo $shell_path >> /etc/shells"
    fi
    sudo chsh -s "$shell_path" "$USER"
}

case "$SHELL" in
    */zsh)
        if [ "$(which zsh)" != '/usr/bin/zsh' ] ; then
            update_shell
        else
            echo "Zsh is already configured"
        fi
        ;;
    *)
        update_shell
        ;;
esac