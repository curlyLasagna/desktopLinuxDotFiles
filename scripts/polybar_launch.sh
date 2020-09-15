#/!bin/bash
# Detect if secondary monitor is connected, if so, add a specific bar and move tray to it
# Else, keep tray on main monitor
# see https://github.com/polybar/polybar/issues/763

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

outputs=$(xrandr --query | grep " connected" | cut -d" " -f1 | sort -r)
set -- $outputs
tray_output=$1

for m in $outputs; do
	if [ $m == $1 ]
	then
		MONITOR1=$m polybar -c "~/.config/polybar/polybar.config" --reload 2bwm &	
	elif [ $m == $2 ]
	then
		tray_output=$m
		MONITOR2=$m polybar -c "~/.config/polybar/polybar.config" --reload sideBar &
	else
		MONITOR1=$m polybar -c "~/.config/polybar/polybar.config" --reload 2bwm &
	fi
done

for m in $outputs; do
	export MONITOR1=$1
	export MONITOR2=$2
	export TRAY_POSITION=none
	if [[ $m == $tray_output ]]; then
		 TRAY_POSITION=right
fi
done
