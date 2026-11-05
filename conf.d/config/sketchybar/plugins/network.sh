#!/bin/sh
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# IP of the default-route interface (like waybar's {ipaddr}); red when offline.
IF="$(route -n get default 2>/dev/null | awk '/interface:/{print $2}')"
# Real IPv4 if there is one; on IPv6-only networks (464XLAT) the only v4 is 192.0.0.x
V4="$([ -n "$IF" ] && ifconfig "$IF" | awk '/inet /{print $2}' | grep -v '^192\.0\.0\.' | head -1)"
# Stable global IPv6 (skip link-local, rotating temporary, and the clat46 translation address)
V6="$([ -n "$IF" ] && ifconfig "$IF" | awk '/inet6 / && /secured/ && !/temporary/ && !/clat46/ && $2 !~ /^fe80/ {print $2}' | head -1)"
# Full IPv6 is too long for the bar: show only the last two groups
[ -n "$V6" ] && V6="…$(echo "$V6" | awk -F: '{print $(NF-1)":"$NF}')"
IP="${V4:-$V6}"
WIFI_DEV="$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}')"

if [ -z "$IP" ]; then
  sketchybar --set "$NAME" icon="󰖪" label="Disconnected" background.color=0xffbf616a
elif [ "$IF" = "$WIFI_DEV" ]; then
  sketchybar --set "$NAME" icon="󰖩" label="$IP" background.color=0xff81a1c1
else
  sketchybar --set "$NAME" icon="󰈀" label="$IP" background.color=0xff81a1c1
fi
