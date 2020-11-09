#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    zscroll -n false -l 10 --delay 0.1 "  $(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    zscroll -n false -l 10 --delay 0 "  $(playerctl metadata artist) - $(playerctl metadata title)"
else
    echo ""
fi
