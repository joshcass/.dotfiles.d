#!/usr/bin/env fish

function ct
  if ! test -f $HOME/.config/alacritty/colors.yml
    echo "file $HOME/.config/alacritty/colors.yml doesn't exist"
    return
  end

  set -l theme (grep -q '^colors:.*light' $HOME/.config/alacritty/colors.yml && echo "dark" || echo "light")

  sed -i -e "s/^colors:.*/colors: *solarized_$theme/" $HOME/.config/alacritty/colors.yml
end
