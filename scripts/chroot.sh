#/bin/bash

if [[ $# -ne 1 ]] ; then
  echo "Usage: $0 <directory>"
  exit 1
fi;

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

if [[ "$1" = /* ]]
then
  DIR=$1
else
  DIR=$(pwd)/$1
fi

if [[\
  (! -e $DIR) || \
  (! -e $DIR/dev) || \
  (! -e $DIR/dev/pts) || \
  (! -e $DIR/proc) || \
  (! -e $DIR/sys) || \
  (! -e $DIR/tmp) \
  ]] ; then
  echo "Sorry $DIR doesn't exists or isn't a valid location for chroot!"
  echo "Have you mounted the filesystem in $DIR?"
  echo "You must have directories: etc, dev, dev/pts, proc, sys and tmp"
  exit 1
fi;

mount -o bind /dev $1/dev
mount -o bind /dev/pts $1/dev/pts
mount -t proc none $1/proc
mount -o bind /sys $1/sys
mount -o bind /tmp $1/tmp

cp /etc/resolv.conf $1/etc

cd $1

chroot . /bin/bash
