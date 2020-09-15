#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

$HOME/scripts/xidlehookLock.sh &
sleep 1 ; $HOME/.screenlayout/defaultLayout.sh

session=${1:-spectrwm}

case "$session" in
	2bwm)	
		dunst &									
		picom -b
		$HOME/scripts/polybar_launch.sh & 
		$HOME/scripts/setWallpaper.sh
		exec 2bwm > /tmp/2bwm.log
		redshift-gtk
		;;
	spectrwm) 
		exec spectrwm > /tmp/spectrwm.log
		;;
	leftwm)
		exec dbus-launch leftwm > /tmp/spectrwm.log
		;;
	*)
		exec "$session"
esac
