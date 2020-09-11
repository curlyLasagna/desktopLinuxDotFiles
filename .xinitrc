#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset b off
# notification daemon
dunst & 														
# compositor
picom -b
# xidlehook script
$HOME/scripts/xidlehookLock.sh &
# set xrandr 
sleep 1 ; $HOME/.screenlayout/defaultLayout.sh

session=${1:-2bwm}

case "$session" in
	2bwm)	
		# launch bar
		$HOME/scripts/polybar_launch.sh & 
		# set background
		$HOME/scripts/setWallpaper.sh
		exec 2bwm 2> /tmp/2bwm.log
		;;
	spectrwm) 
		exec spectrwm 2> /tmp/spectrwm.log
		;;
	*)
		exec "$session"
esac
