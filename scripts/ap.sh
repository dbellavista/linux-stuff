#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Obtaining super user privileges"
	sudo "$0" "$@"
	exit $?
fi

case ${1} in
	'start')
		sysctl -w net.ipv4.ip_forward=1
		iptables -A FORWARD -j ap-router
		iptables -t nat -A POSTROUTING -j ap-nat-post
		ip addr add 192.168.1.1/24 dev wlan0
		rc-service dnsmasq start
		rc-service haveged start
		hostapd /etc/hostapd/hostapd.conf &;;

	'stop')
	  pkill hostapd
		sysctl -w net.ipv4.ip_forward=0
		iptables -D FORWARD -j ap-router
		iptables -t nat -D POSTROUTING -j ap-nat-post
		rc-service dnsmasq stop
		rc-service haveged stop
		ip addr del 192.168.1.1/24 dev wlan0;;
	*)
		echo "Usage: $0 (start|stop)"
		exit 1;;
esac

exit 0
