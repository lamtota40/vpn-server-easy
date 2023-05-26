#!/bin/bash

sync; echo 1 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a
du -sh /var/log/*
truncate -s 0 /var/log/syslog
