create_schemes_dir() {
    if [ ! -d ~/.config/tilix/schemes ]; then
        echo "Creating schemes directory"
        mkdir -p ~/.config/tilix/schemes
    else
        echo "schemes directory already exists"
    fi
}

create_schemes_dir

echo "removing existing scheme symlinks"
ls $DOTFILES/setup/tilix/color_schemes | xargs -L 1 -I{} rm ~/.{}

echo "symlinking color schemes"
ls $DOTFILES/setup/tilix/color_schemes | xargs -L 1 -I{} ln -s $DOTFILES/setup/tilix/color_schemes/{} ~/.config/tilix/schemes/
