#!/bin/bash

if [ -f /etc/systemd/system/demo3.service ]; then
    echo "systemd unit already installed!"
else
    sudo cp ./backend/demo3.service /etc/systemd/system/demo3.service
    sudo systemctl daemon-reload
    echo "systemd unit installed!"
fi