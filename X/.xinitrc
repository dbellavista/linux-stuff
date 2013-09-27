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
xcompmgr -c &

export _JAVA_AWT_WM_NONREPARENTING=1
xsetroot -cursor_name left_ptr
setxkbmap it us
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

grep --quiet Gentoo /proc/version
GENTOO=$?

PARAMS=""
if [ $GENTOO -eq 0 ]; then
#	PARAMS="ck-launch-session dbus-launch --sh-syntax --exit-with-session"
PARAMS="dbus-launch --sh-syntax --exit-with-session"

fi

if [ -z "$1" ]
then
  WM=awesome
else
  WM=$1
fi

source ~/.zshrc
exec $PARAMS $WM
