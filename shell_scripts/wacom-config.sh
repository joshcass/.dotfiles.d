#!/usr/bin/env sh

for i in $(seq 10); do
    if xsetwacom list devices | grep -q Wacom; then
        break
    fi
    sleep 1
done

stylus="Wacom One by Wacom S Pen stylus"

xsetwacom set "${stylus}" Button 2 3
xsetwacom set "${stylus}" Button 3 "pan"
xsetwacom set "${stylus}" Rotate "half"
xsetwacom set "${stylus}" PanScrollThreshold 200
