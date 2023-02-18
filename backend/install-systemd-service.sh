#!/bin/bash

if [ -f ~/.local/share/systemd/user/demo3.service ]; then
    echo "systemd unit already installed!"
else
    mkdir -p ~/.local/share/systemd/user/
    cp ./demo3.service ~/.local/share/systemd/user/demo3.service
    sudo systemctl enable petclinic --now
    echo "systemd unit installed!"
fi