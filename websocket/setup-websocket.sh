#!/bin/bash

apt install python -y
curl -skL "$GIST/startnoload" -o /usr/local/sbin/startnoload
chmod +x /usr/local/sbin/startnoload
