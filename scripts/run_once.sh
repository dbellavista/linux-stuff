#!/bin/bash
# Run program unless it's already running.

if ! ps ax | grep $1 | grep -v grep | grep -v $0  > /dev/null
then
	${@:2} &
fi
