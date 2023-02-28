#!/bin/bash

# Write log file:
exec > >(tee /var/log/user_data.log|logger -t user-data -s 2>/dev/console) 2>&1


# Install jenkins:
sudo apt update
sudo apt install default-jre -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw allow 8080

# Configure jenkins:
export JENKINS_PASSWD="$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
chmod u+x jenkins-cli.jar

# Install base jenkins plugins:
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin workflow-aggregator

# Install jenkins plugins for frontend:
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin pipeline-aws
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin discord-notifier
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin ssh-agent
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin ssh-slaves -restart

# Install jenkins plugins for backend:
# ...

# Clone devops repository: // TODO :: or using other ways for getting jenkinsfile
sudo git clone https://github.com/dimdimuzun/devops.git -b dev # TODO :: checkout to main in prod => replace this to config

# Create jenkins frontend job by jenkinsfile:
# THIS IS TEST!!! # TODO :: fix for frontend
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD create-job test_pipeline < ./devops/backend/test-pipeline.xml
