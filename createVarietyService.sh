#!/usr/bin/env bash

cd /etc/systemd/system

echo "
[Unit]
Description=variety service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=/usr/bin/python /usr/bin/variety

[Install]
WantedBy=multi-user.target
" > variety.service

chmod 777 variety.service

# how to remove service
#systemctl stop [servicename]
#systemctl disable [servicename]
#rm /etc/systemd/system/[servicename]
#rm /etc/systemd/system/[servicename] symlinks that might be related
#systemctl daemon-reload
#systemctl reset-failed