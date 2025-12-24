#!/bin/bash

current=$(powerprofilesctl get)

if [ "$current" = "performance" ]; then
    next="balanced"
elif [ "$current" = "balanced" ]; then
    next="power-saver"
else
    next="performance"
fi

powerprofilesctl set "$next"
notify-send "⚡ Power Mode" "Switched to $next"
