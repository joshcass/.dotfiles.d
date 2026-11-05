#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Fill the calendar popup (like waybar's clock tooltip): month grid, today in [brackets]
calendar() {
  first_dow="$(date -j -f %Y-%m-%d "$(date +%Y-%m-01)" +%w)"   # 0 = Sunday
  days="$(date -j -v1d -v+1m -v-1d +%d)"
  today="$(date +%-d)"
  lines="$(awk -v f="$first_dow" -v n="$days" -v t="$today" 'BEGIN {
    print " Su  Mo  Tu  We  Th  Fr  Sa "
    line = ""; for (i = 0; i < f; i++) line = line "    "
    for (d = 1; d <= n; d++) {
      line = line (d == t ? sprintf("[%2d]", d) : sprintf(" %2d ", d))
      if ((d + f) % 7 == 0 || d == n) { print line; line = "" }
    }
  }')"
  args=(--set cal.title label="$(date '+%A %-d %B %Y')")
  i=0
  while IFS= read -r l; do
    args+=(--set "cal.$i" label="$l" drawing=on); i=$((i + 1))
  done <<LINES
$lines
LINES
  while [ $i -le 6 ]; do args+=(--set "cal.$i" drawing=off); i=$((i + 1)); done
  sketchybar "${args[@]}"
}

case "$SENDER" in
  mouse.clicked)        calendar; sketchybar --set "$NAME" popup.drawing=toggle ;;
  mouse.exited.global)  sketchybar --set "$NAME" popup.drawing=off ;;
  *)                    sketchybar --set "$NAME" label="$(date '+%d-%m | %H:%M')" ;;
esac
