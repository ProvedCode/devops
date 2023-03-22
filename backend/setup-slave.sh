#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install openjdk-17-jre git -y
mkdir -p /var/lib/jenkins
useradd -d /var/lib/jenkins -s /bin/bash -G sudo jenkins
mkdir -p /var/lib/jenkins/.ssh
touch /var/lib/jenkins/.ssh/authorized_keys
chown jenkins:jenkins -R /var/lib/jenkins
chmod 700 /var/lib/jenkins/.ssh
chmod 400 /var/lib/jenkins/.ssh/authorized_keys