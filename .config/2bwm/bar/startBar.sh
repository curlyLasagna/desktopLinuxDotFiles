#!/bin/sh

BAR_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
FONT="IBM Plex Mono"
BAR_HEIGHT=25
FONT_SIZE=10
BG='#111111'
~/.config/2bwm/bar/bar.sh | lemonbar -p -g "$BAR_WIDTH"x$BAR_HEIGHT -f "$FONT:size=$FONT_SIZE" -B $BG
