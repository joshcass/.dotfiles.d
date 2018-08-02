#!/bin/bash

ls color_schemes | xargs -L 1 -I{} ln -s $PWD/color_schemes/{} ~/.config/tilix/schemes/
