#!/usr/bin/env fish
# Generate a random 32 bit password

function pw
    pwgen -ys -r ',.\/~:;\"\'`|' 32 1
end
