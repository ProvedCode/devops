#!/bin/bash

if [ -f /etc/systemd/system/ProvedCode.service ]; then
    echo "systemd unit already installed!"
else
    sudo cp ./backend/ProvedCode.service /etc/systemd/system/ProvedCode.service
    sudo systemctl daemon-reload
    echo "systemd unit installed!"
fi