#!/bin/bash

if [ -z "$IM_CONSOLE" ] ; then
  # Killing windows
  for win in $(wmctrl -l | awk '{print $1}'); do
    wmctrl -i -c $win
  done
fi

# Killing redshift and waiting prevents the monitor to break
if pgrep redshift; then
  pkill redshift
  sleep 3
fi
