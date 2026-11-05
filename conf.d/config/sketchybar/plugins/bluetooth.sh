#!/bin/sh
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

INFO="$(system_profiler SPBluetoothDataType 2>/dev/null)"
if ! echo "$INFO" | grep -q "State: On"; then
  ICON="󰂲"
elif echo "$INFO" | grep -q "^ *Connected:$"; then
  ICON="󰂱"
else
  ICON="󰂯"
fi
sketchybar --set "$NAME" icon="$ICON"
