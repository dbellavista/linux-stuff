#!/bin/bash

TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
echo $(($TEMP / 1000))°
