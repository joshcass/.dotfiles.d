#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Show workspaces that have windows, plus the focused one; highlight the focused one.
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
OCCUPIED=" $(aerospace list-workspaces --monitor all --empty no | tr '\n' ' ') "

args=()
for ws in 1 2 3 4 5 6 7 8 9 10 S; do
  if [ "$ws" = "$FOCUSED" ]; then
    args+=(--set "ws.$ws" drawing=on background.drawing=on label.color=0xff2e3440)
  elif [[ "$OCCUPIED" == *" $ws "* ]]; then
    args+=(--set "ws.$ws" drawing=on background.drawing=off label.color=0xffeceff4)
  else
    args+=(--set "ws.$ws" drawing=off)
  fi
done
sketchybar "${args[@]}"
