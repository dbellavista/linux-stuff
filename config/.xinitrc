export _JAVA_AWT_WM_NONREPARENTING=1
xsetroot -cursor_name left_ptr
setxkbmap it us

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/bin/awesome
