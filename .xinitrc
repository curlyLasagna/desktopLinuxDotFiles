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
# set xrandr 
sleep 1 ; $HOME/.screenlayout/defaultLayout.sh
# compositor
picom -b
# set background
$HOME/scripts/setWallpaper.sh
# xidlehook script
$HOME/scripts/xidlehookLock.sh &
# launch bar
$HOME/scripts/polybar_launch.sh & 

exec 2bwm 
