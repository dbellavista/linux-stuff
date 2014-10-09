#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Obtaining super user privileges"
	sudo "$0" "$@"
	exit $?
fi

case ${1} in
	'start')
		sysctl -w net.ipv4.ip_forward=1
		ip addr add 192.168.66.1/24 dev wlp3s0
		ip link set up dev wlp3s0
		iptables -A FORWARD -j ap-router
		iptables -t nat -A POSTROUTING -j ap-nat-post
		systemctl start dnsmasq
		systemctl start haveged
		hostapd /etc/hostapd/hostapd.conf &;;

	'stop')
	  pkill hostapd
		sysctl -w net.ipv4.ip_forward=0
		iptables -D FORWARD -j ap-router
		iptables -t nat -D POSTROUTING -j ap-nat-post
		systemctl stop dnsmasq
		systemctl stop haveged
		ip addr del 192.168.66.1/24 dev wlp3s0;;
	*)
		echo "Usage: $0 (start|stop)"
		exit 1;;
esac

exit 0
