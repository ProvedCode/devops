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
java -Djenkins.install.runSetupWizard=false -jar jenkins.war

echo "JAVA_ARGS=Djenkins.install.runSetupWizard=false" >> /etc/default/jenkins
touch /var/lib/jenkins/init.groovy.d/basic-security.groovy

echo "#!groovy" >> /var/lib/jenkins/init.groovy.d/basic-security.groovy
echo "import jenkins.model.*" >> /var/lib/jenkins/init.groovy.d/basic-security.groovy
echo "import hudson.util.*;" >> /var/lib/jenkins/init.groovy.d/basic-security.groovy
echo "import jenkins.install.*;" >> /var/lib/jenkins/init.groovy.d/basic-security.groovy
echo "def instance = Jenkins.getInstance()" >> /var/lib/jenkins/init.groovy.d/basic-security.groovy
echo "instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)" >> /var/lib/jenkins/init.groovy.d/basic-security.groovy

# sudo systemctl restart jenkins
# sudo rm -rf /var/lib/jenkins/init.groovy.d/basic-security.groovy
