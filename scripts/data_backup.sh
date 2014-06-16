#!/bin/bash

BSTONE=$(mount | grep $(echo -E '^/dev/'$(readlink /dev/disk/by-uuid/8c30a3a1-3647-4e0d-a39f-e3697b13d180 | grep -oE 'sd\w[0-9]+')) | awk '{print $3}')

echo $BSTONE

echo -e "*** Doc backup ***"
echo -e "\t[*] Syncing Documents"
rsync --progress -ca --delete $HOME/Documents/ $BSTONE/Documents/Documents
echo -e "\t[*] Syncing linux conf"
rsync --progress -ca --delete $STUFF/ $BSTONE/Documents/linux-stuff
echo -e "\t[*] Syncing portage dir"
rsync --progress -ca --delete /etc/portage/ $BSTONE/Documents/portage
echo -e "\t[*] Syncing Work"
rsync --progress -ca $HOME/Work/ $BSTONE/Documents/Work

echo -e "*** Media backup ***"
echo -e "\t[*] Syncing Music"
rsync --progress -ca $HOME/Music/ $BSTONE/Media/Music
echo -e "\t[*] Syncing Pictures"
rsync --progress -ca $HOME/Pictures/ $BSTONE/Media/Pictures
echo -e "\t[*] Syncing Videos"
rsync --progress -ca $HOME/Videos/ $BSTONE/Media/Videos
