#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Stare gnome-keyring-daemon
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK

# $HOME/scripts/xidlehookLock.sh &
xset dpms 0 600 600
xset s off
picom -b
setxkbmap -option terminate:ctrl_alt_bksp
feh --bg-fill ~/Pictures/1920x1080/lighthouse.jpg
libinput-gestures-setup start
session=${1:-i3}

case $session in
    2bwm)       
        exec 2bwm & /home/luis/.config/2bwm/bar/startBar.sh 
        ;;
	spectrwm)   
        exec spectrwm 
        ;;
   	sowm)       
        exec sowm 
        ;;
    i3)         
        exec i3 
        ;;
    gnome-x11)
        export XDG_SESSION_TYPE=x11
        export GDK_BACKEND=x11
        exec gnome-session
        ;;
    gnome)
        XDG_SESSION_TYPE=wayland dbus-run-session gnome-session
        ;;
	*)          
        exec $session
        ;; 
esac
