#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
	if [ "$(playerctl metadata artist)" = "No player could handle this command" ]; then
			echo ""
	else
    echo "  $(playerctl metadata artist) - $(playerctl metadata title)"
	fi
elif [ "$player_status" = "Paused" ]; then
    echo "  $(playerctl metadata artist) - $(playerctl metadata title)"
else
    echo ""
fi
