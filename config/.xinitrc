#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset -b

export _JAVA_AWT_WM_NONREPARENTING=1
xsetroot -cursor_name left_ptr
setxkbmap it us
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

grep --quiet Gentoo /proc/version
GENTOO=$?

PARAMS=""
if [ $GENTOO -eq 0 ]; then
	PARAMS="ck-launch-session dbus-launch --sh-syntax --exit-with-session"
fi

if [ -z "$1" ]
then
	exec $PARAMS awesome
else
	exec $PARAMS $1
fi
