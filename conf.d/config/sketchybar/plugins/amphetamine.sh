#!/bin/sh
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Amphetamine session indicator/toggle (like waybar's idle_inhibitor).
# Hidden when Amphetamine isn't running, so it never gets launched by accident.
pgrep -x Amphetamine >/dev/null || { sketchybar --set "$NAME" drawing=off; exit 0; }

amph() { osascript -e "tell application \"Amphetamine\" to $1" 2>/dev/null; }

if [ "$SENDER" = "mouse.clicked" ]; then
  if [ "$(amph 'session is active')" = "true" ]; then amph 'end session'
  else amph 'start new session'; fi      # uses Amphetamine's default duration
fi

if [ "$(amph 'session is active')" = "true" ]; then
  sketchybar --set "$NAME" drawing=on icon="" background.color=0xffebcb8b   # active: yellow
else
  sketchybar --set "$NAME" drawing=on icon="" background.color=0xff81a1c1
fi
