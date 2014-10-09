#!/bin/bash

DISP=$(xrandr | grep -v LVDS1 | grep -oE '\w+ connected' | awk '{print $1}')

if [[ -z "$DISP" ]] ; then
  TOOFF=$(xrandr | grep -v LVDS1 | grep -oE '\w+ disconnected [0-9]+.* \(' | awk '{print $1}')
  [[ -z "$TOOFF" ]] || xrandr --output $TOOFF --off
else
  if [[ "$DISP" == "HDMI1" ]]; then
    xrandr --output $DISP --auto --right-of LVDS1
  else
    xrandr --output $DISP --auto --right-of LVDS1
  fi
fi
