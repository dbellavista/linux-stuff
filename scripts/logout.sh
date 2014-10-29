#!/bin/bash

if [ -z "$IM_CONSOLE" ] ; then
  # Killing windows
  for win in $(wmctrl -l | awk '{print $1}'); do
    wmctrl -i -c $win
  done
fi

# Killing redshift and waiting prevents the monitor to break
# Only if there are no other sessions

sess=$(who | grep -v pts | wc -l)
if [[ $sess -eq 1 ]]; then # :0.0 or ttys
  if pgrep redshift; then
    pkill redshift
    sleep 3
  fi
fi
