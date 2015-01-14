#!/bin/bash
#
# flac2mp3.sh
#
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#

for f in *.flac; do
  /usr/bin/avconv -i "$f" -qscale:a 0 "${f[@]/%flac/mp3}"
done
