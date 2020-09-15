#!/bin/sh

pkill $0
mem() {
	free | grep Mem | awk '{ printf("%d%\n", $3/$2 * 100.0) }'
}

vol() {
	muted=$(pamixer --sink 0 --get-mute)

	if [ "$muted" = true ]; then
			echo "Mute"
	else
			volume=$(pamixer --sink 0 --get-volume)
				echo "$volume%"
	fi
}

redshift() {
	if [ "$(pgrep -x redshift)" ]; then
			temp=$(redshift -p 2> /dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")

			if [ -z "$temp" ]; then
					echo "%{F#65737E} #"
			elif [ "$temp" -ge 5000 ]; then
					echo "%{F#8FA1B3} #"
			elif [ "$temp" -ge 4000 ]; then
					echo "%{F#EBCB8B} #"
			else
					echo "%{F#D08770} #"
			fi
	fi
}

# https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/player-mpris-simple
player() {
	player_status=$(playerctl status 2> /dev/null)

	if [ "$player_status" = "Playing" ]; then
			echo "$(playerctl metadata artist) - $(playerctl metadata title)" | \
				awk -v len=40 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
			# zscroll -n false -l 20 --delay 0.1 "$(playerctl metadata artist) - $(playerctl metadata title)"
	elif [ "$player_status" = "Paused" ]; then
			echo "$(playerctl metadata artist) - $(playerctl metadata title)" | \
				awk -v len=40 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
			# zscroll -n false -l 20 --scroll 0 "$(playerctl metadata artist) - $(playerctl metadata title)"
	else
			echo ""
	fi
}

cpu_avg() {
	echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]%
}

# https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/openweathermap-forecast
weather() {
	get_icon() {
			case $1 in
					# Icons for weather-icons
					01d) icon="";; 
					01n) icon="";;
					02d) icon="";;
					02n) icon="";;
					03*) icon="";;
					04*) icon="";;
					09d) icon="";;
					09n) icon="";;
					10d) icon="";;
					10n) icon="";;
					11d) icon="";;
					11n) icon="";;
					13d) icon="";;
					13n) icon="";;
					50d) icon="";;
					50n) icon="";;
					*) icon="";
			esac

			echo $icon
	}

	KEY="82206c82ae9a45624368a4abeb8c0cf8"
	CITY="Annapolis"
	UNITS="Imperial"
	SYMBOL="°"

	API="https://api.openweathermap.org/data/2.5"

	if [ -n "$CITY" ]; then
			if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
					CITY_PARAM="id=$CITY"
			else
					CITY_PARAM="q=$CITY"
			fi

			current=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
			forecast=$(curl -sf "$API/forecast?appid=$KEY&$CITY_PARAM&units=$UNITS&cnt=1")
	else
			location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

			if [ -n "$location" ]; then
					location_lat="$(echo "$location" | jq '.location.lat')"
					location_lon="$(echo "$location" | jq '.location.lng')"

					current=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
					forecast=$(curl -sf "$API/forecast?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
			fi
	fi

	if [ -n "$current" ] && [ -n "$forecast" ]; then
			current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
			current_icon=$(echo "$current" | jq -r ".weather[0].icon")

			forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
			forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].icon")

			if [ "$current_temp" -gt "$forecast_temp" ]; then
					trend=""
			elif [ "$forecast_temp" -gt "$current_temp" ]; then
					trend=""
			else
					trend=""
			fi

			echo "+@fn=2;$(get_icon "$current_icon") +@fn=0;$current_temp$SYMBOL +@fn=2;$trend  +@fn=2;$(get_icon "$forecast_icon") +@fn=0;$forecast_temp$SYMBOL"
	fi
}

SLEEP_SEC=1
while :; do   
	echo "+@fg=3;Cpu:$(cpu_avg) +@fn=0;+@fg=4;Ram:$(mem) +@fn=0;+@fg=2;Vol:$(vol) +@fg=5;$(weather)"
		sleep $SLEEP_SEC
done

