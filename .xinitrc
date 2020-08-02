#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset b off
xset s off
xset dpms 600 60 60

mainWallpaper="$HOME/Pictures/WideHardo/yosemite-valley-evening-5k-pt-2560x1080.jpg"
sideWallpaper="$HOME/Pictures/pogo/yosemite-ca-5k-1080x1920.jpg"

# notification daemon
dunst & 														
# set xrandr 
sleep 1 ; $HOME/.screenlayout/defaultLayout.sh
# compositor
picom -b
# launch polybar
~/scripts/polybar_launch.sh &
# set background
feh --bg-scale $mainWallpaper $sideWallpaper
exec 2bwm 
