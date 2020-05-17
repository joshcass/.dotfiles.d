echo "Ensuring directories exist"
mkdir -p $HOME/.config/gtk-3.0
mkdir -p $HOME/.config/terminator

echo "Removing existing links or files"
rm $HOME/.config/terminator/config
rm $HOME/.config/gtk-3.0/gtk.css

echo "Creating new symlinks"
ln -s $dir/terminator/gtk.css $HOME/.config/gtk-3.0/gtk.css
ln -s $dir/terminator/config $HOME/.config/terminator/config
