#!/bin/sh
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

BATT="$(pmset -g batt)"
PCT="$(echo "$BATT" | grep -Eo '[0-9]+%' | head -1 | tr -d %)"
[ -z "$PCT" ] && { sketchybar --set "$NAME" drawing=off; exit 0; }

if   [ "$PCT" -ge 90 ]; then ICON=""
elif [ "$PCT" -ge 60 ]; then ICON=""
elif [ "$PCT" -ge 35 ]; then ICON=""
elif [ "$PCT" -ge 15 ]; then ICON=""
else ICON=""; fi

COLOR=0xff81a1c1                                   # normal
if echo "$BATT" | grep -q "AC Power"; then
  ICON="󰂄"; COLOR=0xffa3be8c            # charging / plugged: green
elif [ "$PCT" -le 15 ]; then
  COLOR=0xffbf616a                                 # low: red
fi

sketchybar --set "$NAME" icon="$ICON" label="$PCT%" background.color=$COLOR
