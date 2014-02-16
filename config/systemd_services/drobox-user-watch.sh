#!/bin/bash
echo 100000 | tee /proc/sys/fs/inotify/max_user_watches
