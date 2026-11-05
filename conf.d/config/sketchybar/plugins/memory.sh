#!/bin/sh
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Memory in use = 100 - macOS "system-wide memory free percentage"
FREE="$(memory_pressure | awk -F': ' '/free percentage/{gsub("%","",$2); print $2}')"
[ -n "$FREE" ] && sketchybar --set "$NAME" icon="󰍛" label="$((100 - FREE))%"
