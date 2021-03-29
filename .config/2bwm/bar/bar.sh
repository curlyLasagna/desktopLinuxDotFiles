#!/bin/sh

workspace() {
    WS=$(xprop -root _NET_CURRENT_DESKTOP | sed -e 's/_NET_CURRENT_DESKTOP(CARDINAL) = //')
    echo -n "$WS"
}
time() {
    DATE=$(date +"%a %b %e, %I:%M %p")
    echo -n "$DATE"
}

battery() {
    BAT=$(cat /sys/class/power_supply/BAT1/capacity)
    echo -n "$BAT"
}

volume() {
    VOLUME=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
    echo -n "$VOLUME"
}

ssid() {
    SSID=$(/bin/iwgetid -r)
    echo -n "$SSID"
}

mem() {
    MEM=$(free -h | awk 'FNR == 2 {print $3}')
    echo -n "$MEM"
}

PADDING=3
while true; do
    echo "%{O2}%{l}$(workspace)%{c}$(time)%{r}Mem: $(mem)%{O$PADDING} | Bat: $(battery)%%{O$PADDING} | Vol: $(volume)%%{O$PADDING} | SSID: $(ssid)%{O2}"
    sleep 0.5;
done
