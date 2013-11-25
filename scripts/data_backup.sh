#!/bin/bash
echo -e "==== Doc backup ====="
echo -e "\tSyncing Documents"
rsync -ca --delete $HOME/Documents/ /mnt/hd/backup_doc/Documents
echo -e "\tSyncing linux conf"
rsync -ca --delete $STUFF/ /mnt/hd/backup_doc/linux-stuff
echo -e "\tSyncing portage dir"
rsync -ca --delete /etc/portage/ /mnt/hd/backup_doc/portage
echo -e "\tSyncing Papers"
rsync -ca --delete /mnt/shared/papers/ /mnt/hd/backup_doc/papers/

echo -e "==== Doc backup ====="
echo -e "\tSyncing Music"
rsync -ca /mnt/media/Music/ /mnt/hd/media/Music/
echo -e "\tSyncing Pictures"
rsync -ca /mnt/media/Pictures/ /mnt/hd/media/Pictures
echo -e "\tSyncing Videos"
rsync -ca /mnt/media/Videos/ /mnt/hd/media/Videos
