#!/bin/bash

BPATH=/mnt/data/Documents/Dropbox/Various/Backup/

HPATH=/home/daniele/

HDIRS=(linux .ssh/)

#### Linux Backup

for i in ${HFILES[@]}
do
	echo ${HPATH}${i}
	rsync -a --delete ${HPATH}${i} ${BPATH}${i}
done

for i in ${HDIRS[@]}
do
	echo ${HPATH}${i}
	mkdir -p ${BPATH}${i}
	rsync -a -r --delete ${HPATH}${i} ${BPATH}${i}
done
