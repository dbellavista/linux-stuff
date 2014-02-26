#!/bin/bash

if [[ "$1" != ssh://* ]] ; then
  echo "Wrong protocol"
  exit 1
fi

SSHPATH=$1
SSHPATH=${SSHPATH:6}

CLEAN=${SSHPATH// /_}
CLEAN=${CLEAN//[^a-zA-Z0-9_]/_}
CLEAN=`echo -n $CLEAN | tr A-Z a-z`

MOUNT=/tmp/$CLEAN
mkdir -p "$MOUNT"

sshfs $SSHPATH: $MOUNT && echo SSH mounted at $MOUNT
