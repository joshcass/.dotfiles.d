#!/bin/bash

echo | sudo tee /usr/share/libinput/local-overrides.quirks <<END_TEXT
[Touchpad pressure override]
MatchName=*Magic Trackpad 2
AttrPressureRange=2:0
END_TEXT
