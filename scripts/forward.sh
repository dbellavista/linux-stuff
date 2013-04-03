#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Obtaining super user privileges"
	sudo "$0" "$@"
	exit $?
fi

case ${1} in
	'cable')
		sysctl -w net.ipv4.ip_forward=1
		iptables -A FORWARD -j cable-router
		iptables -t nat -A POSTROUTING -j cable-nat-post;;
	'ap')
		sysctl -w net.ipv4.ip_forward=1
		iptables -A FORWARD -j ap-router
		iptables -t nat -A POSTROUTING -j ap-nat-post;;
	'stop')
		sysctl -w net.ipv4.ip_forward=0
		iptables -F FORWARD
		iptables -t nat -F POSTROUTING;;
	*)
		echo "Usage: $0 (cable|ap|stop)"
		exit 1;;
esac

exit 0
