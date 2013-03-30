#!/bin/bash

#### General Backup
## Dropbox Folder (NTFS)
#echo "[NTFS] Backing up dropbox folder..."
#rsync -r --delete /home/daniele/Documents/Dropbox/ /run/media/daniele/DB-500_NTFS/Backup/Dropbox/
### Pictures Folder
#echo "[NTFS] Backing up pictures folder..."
#rsync -r --delete /home/daniele/Pictures/ /run/media/daniele/DB-500_NTFS/Backup/Pictures/
### Music Folder
echo "[NTFS] Backing up music folder..."
rsync -r --delete /home/daniele/Music/ /run/media/daniele/DB-500_NTFS/Backup/Music/
## Video Folder
#echo "[NTFS] Backing up video folder..."
#rsync -r --delete /home/daniele/Videos/ /run/media/daniele/DB-500_NTFS/Backup/Videos/

#### Linux Backup
## Myscript folder
echo "[EXT4] Backing up myscripts folder..."
rsync -a -r --delete /home/daniele/.myscripts/ /run/media/daniele/DB-500_EXT4/backup/daniele/.myscripts/
# Vim files
echo "[EXT4] Backing up vim files and folders..."
rsync -a --delete /home/daniele/.vimrc /run/media/daniele/DB-500_EXT4/backup/daniele/.vimrc
rsync -a -r --delete /home/daniele/.vim/ /run/media/daniele/DB-500_EXT4/backup/daniele/.vim/

## Dropbox Folder (EXT4)
echo "[EXT4] Backing up dropbox folders..."
rsync -a -r --delete /home/daniele/Documents/Dropbox/ /run/media/daniele/DB-500_EXT4/backup/daniele/Documents/Dropbox/



