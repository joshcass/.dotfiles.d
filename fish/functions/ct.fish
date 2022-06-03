#!/usr/bin/env fish

function ct
  if ! test -f ~/.config/alacritty/colors.yml
    echo "file ~/.config/alacritty/colors.yml doesn't exist"
    return
  end

  set -l theme (grep -q '^colors:.*light' $DOTFILES/alacritty/colors.yml && echo "dark" || echo "light")

  sed -i -e "s/^colors:.*/colors: *solarized_$theme/" $DOTFILES/alacritty/colors.yml
end
