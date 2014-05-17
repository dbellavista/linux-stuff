#!/bin/bash

export PATH="$PATH $STUFF/bin"

bash ~/linux/scripts/run_once.sh "dropbox" "$HOME/linux/scripts/start_dropbox.sh"
bash ~/linux/scripts/run_once.sh "redshift" "redshift"
