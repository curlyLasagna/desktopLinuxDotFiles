#!/bin/sh

xidlehook \
	--not-when-fullscreen \
	--not-when-audio \
	--timer 2400 \
		'slock xset dpms force off' \
		''
