#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Obtaining super user privileges"
	sudo "$0" "$@"
	exit $?
fi

hexchars="0123456789abcdef"
end=$( for i in {1..6} ; do echo -n ${hexchars:$(( $RANDOM % 16 )):1} ; done | sed -e 's/\(..\)/:\1/g' )

RANDOM_MAC="e0:61:b2$end"
STATIC_MAC="d4:85:64:0f:44:20"

if [ "$#" -eq 2 ]; then
  MAC="$2"
else
  MAC=$RANDOM_MAC
fi

echo "Changing $1 mac address to $MAC"

case ${1} in
	'wlan0')
    ip link set address $MAC dev wlan0;;
	'eth0')
    ip link set address $MAC dev eth0;;
  *)
    echo "Sorry only eth0 and wlan0 are allowed"
    exit 1
esac
