#!/bin/bash

# Write log file:
exec > >(tee /var/log/user_data.log|logger -t user-data -s 2>/dev/console) 2>&1


# Install jenkins:
sudo apt update
sudo apt install default-jre -y
sudo apt install wget -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# sudo apt update -y
sudo apt update -o Acquire::AllowInsecureRepositories=true -y
sudo apt install jenkins --allow-unauthenticated -y
sudo systemctl start jenkins && sudo systemctl enable jenkins
sudo systemctl status jenkins

# Configure jenkins:
export JENKINS_PASSWD="$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
sudo wget http://localhost:8080/jnlpJars/jenkins-cli.jar
sudo chmod u+x jenkins-cli.jar

# Install base jenkins plugins:
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin workflow-aggregator
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin google-compute-engine
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin kubernetes

# Install jenkins plugins for frontend:
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin discord-notifier
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin ssh-agent
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$JENKINS_PASSWD install-plugin ssh-slaves -restart

# TODO: Create Pipelines/Jobs

# TODO: Create Jenins admin credentials