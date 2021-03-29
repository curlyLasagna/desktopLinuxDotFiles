#!/bin/sh

xidlehook \
	--not-when-fullscreen \
	--not-when-audio \
	--timer 1200 \
		'slock systemctl suspend' \
		''
