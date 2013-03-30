#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
#iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -I FORWARD 1 -j ACCEPT
