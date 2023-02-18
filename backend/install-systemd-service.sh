#!/bin/bash

if [ -f /usr/lib/systemd/user/demo3.service ]; then
    echo "systemd unit already installed!"
else
    sudo cp ./backend/demo3.service /usr/lib/systemd/user/demo3.service
    sudo systemctl daemon-reload
    sudo systemctl enable petclinic --now
    echo "systemd unit installed!"
fi