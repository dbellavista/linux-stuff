#!/bin/bash

if [[ $# == 3 ]] && [[ $1 == "1" ]] ; then

  sec=$(udisksctl unlock -b $2 | awk '{print $4}')
  if [[ -z $sec ]]; then
    echo 'Error'
    exit 1
  fi
  sec=${sec%?}

  mp=$(udisksctl mount -b $sec | awk '{print $4}')
  if [[ -z $mp ]]; then
    echo 'Error'
    udisksctl lock -b $2
    exit 1
  fi
  mp=${mp%?}

  ln -s "$mp" ~/"$3"
  echo "$HOME/$3"

elif [[ $# == 2 ]] && [[ $1 == "0" ]] ; then

  infos=$(udisksctl info -b $(mount | grep "$(ls -l ~/"$2" | awk '{print $11}')"))
  if [[ -z $infos ]]; then
    echo 'Error'
    exit 1
  fi

  map=$(echo "$infos" | awk 'NR==5' | awk '{print $2}')
  dev=$(echo "$infos" | awk 'NR==4' | awk '{print $2}' | sed "s,'/org/freedesktop/UDisks2/\(.*\)',\1,")

  if ! udisksctl unmount -b "$map" ; then
    echo "Error unmounting $map"
    exit 1
  fi

  rm ~/"$2"


  if ! udisksctl lock -p "$dev" ; then
    echo "Error locking $dev"
    exit 1
  fi

else
  echo "Usage: 1 /dev/to-mount dest-name"
  echo "Usage: 0 dest-name"
fi
