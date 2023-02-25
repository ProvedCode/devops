#!/bin/bash
sudo apt update
sudo apt install default-jre -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw allow 8080

export JENKINS_PASSWD="$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
chmod u+x jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin workflow-aggregator -restart

