#!/bin/bash
# Run program unless it's already running.



if [[ $# -gt 2 ]]; then
  USER=$1
  STR=$2
  CMD=$3
elif [[ $# -gt 1 ]]; then
  USER=`whoami`
  STR=$1
  CMD=$2
else
  echo 'Wrong'
  exit 1
fi

if ! ps -u $USER | grep $STR | grep -v grep | grep -v $0  > /dev/null
then
	$CMD &
fi
