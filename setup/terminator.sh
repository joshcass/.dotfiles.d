echo "Ensuring directories exist"
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/terminator

echo "Removing existing links or files"
rm ~/.config/terminator/config
rm ~/.config/gtk-3.0/gtk.css

echo "Creating new symlinks"
ln -s $dir/terminator/gtk.css ~/.config/gtk-3.0/gtk.css
ln -s $dir/terminator/config ~/.config/terminator/config
