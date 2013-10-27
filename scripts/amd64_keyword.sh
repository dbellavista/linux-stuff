#!/bin/bash

DIR=/var/db/pkg
for i in `ls $DIR` ;do
  for j in `ls $DIR/$i` ; do
    FILE="$DIR/$i/$j/KEYWORDS"
    if [ -f $FILE ]; then
      grep "\~amd64 " $FILE -q && echo =$i/$j \~amd64
    fi
  done
done
