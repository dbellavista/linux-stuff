#!/bin/bash
#sleep 3
#sleep 7
#bash ~/linux/scripts/run_once.sh "nm-applet" "nm-applet"
bash ~/linux/scripts/run_once.sh "wicd-client" "wicd-gtk -t"
bash ~/linux/scripts/run_once.sh "dropbox" "$HOME/linux/scripts/start_dropbox.sh"
bash ~/linux/scripts/run_once.sh "redshift" "redshift"
#bash ~/linux/scripts/run_once.sh "conky" "conky -c $HOME/.conky/conkyrc"
