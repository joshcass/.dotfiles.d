#!/bin/bash
# This script is intended to make switching between laptop and external displays easier when using i3+dmenu
# To run this script, map it to some shortcut in your i3 config, e.g:
# bindsym $mod+p exec --no-startup-id $config/display.sh
# IMPORTANT: run chmod +x on the script to make it executable
# The result is 4 options appearing in dmenu, from which you can choose
#
#https://gist.github.com/amanusk/6b79d407945ca79caa945ce2658fd987
#
# This is your default laptop screen, detect by running `xrandr`
INTERNAL_OUTPUT="eDP1"

# choices will be displayed in dmenu
choices="laptop\nexternal\ndual\nclone"

# Your choice in dmenu will determine what xrandr command to run
chosen=$(echo -e $choices | dmenu -fn "Noto-10.5" -nb "#2E3440" -nf "#ECEFF4" -sb "#5E81AC" -sf "#ECEFF4" -i -p display:)

# This is used to determine which external display you have connected
# This may vary between OS. e.g VGA1 instead of VGA-1
if xrandr | grep -w DP1 | grep -qw connected; then
	EXTERNAL_OUTPUT="DP1"
fi
if xrandr | grep -w DP2 | grep -qw connected; then
	EXTERNAL_OUTPUT="DP2"
fi

reset_desktop() {
	nitrogen --restore
	sleep 1
	compton -b
	killall conky
	start_conky_maia
}

# xrander will run and turn on the display you want, if you have an option for 3 displays, this will need some modifications
case "$chosen" in
	external) xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto --primary && reset_desktop ;;
	laptop) xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT --off && reset_desktop ;;
	clone) xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT && reset_desktop ;;
	dual) xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --left-of $INTERNAL_OUTPUT --primary && reset_desktop ;;
esac
