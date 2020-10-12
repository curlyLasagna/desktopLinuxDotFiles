#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

$HOME/scripts/xidlehookLock.sh &
sleep 1 ; $HOME/.screenlayout/defaultLayout.sh
xset dpms 0 0 3600
xset s off

session=${1:-gnome}

case "$session" in
	2bwm)	
		dunst &									
		picom -b
		$HOME/scripts/polybar_launch.sh & 
		$HOME/scripts/setWallpaper.sh
		exec 2bwm > /tmp/2bwm.log
		pkill redshift
		redshift-gtk
		;;
	spectrwm) 
		exec spectrwm > /tmp/spectrwm.log
		;;
	sowm)
		dunst &									
		picom -b
		$HOME/scripts/setWallpaper.sh
		exec sowm > /tmp/sowm.log
		;;
	gnome)
		export XDG_SESSION_TYPE=x11
		export GDK_BACKEND=x11
		exec gnome-session	
		;;
	*)
		exec "$session"
esac
