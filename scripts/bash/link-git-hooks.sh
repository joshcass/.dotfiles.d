#!/bin/bash
# symlink this to /usr/local/bin
# every time brew upgrades git I lose my hooks, this script restores them
# automagically

dir=$DOTFILES/scripts/git/hooks
git_dir=$(brew --prefix git)/share/git-core/templates/hooks
files="post-checkout"

# link the hooks
for file in $files; do
  echo "Creating symlink for $file"
  ln -s $dir/$file $git_dir
done

echo "Done"
