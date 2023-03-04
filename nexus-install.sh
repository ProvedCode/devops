#!/bin/bash

apt-get update
wget http://security.debian.org/debian-security/pool/updates/main/o/openjdk-8/openjdk-8-jre-headless_8u332-ga-1~deb9u1_amd64.deb -O jre-8-headless.deb
wget http://security.debian.org/debian-security/pool/updates/main/o/openjdk-8/openjdk-8-jre_8u332-ga-1~deb9u1_amd64.deb -O jre-8.deb
apt-get install ./jre-8-headless.deb -y
apt-get install ./jre-8.deb -y
rm ./jre-8-headless.deb ./jre-8.deb
wget https://download.sonatype.com/nexus/3/nexus-3.48.0-01-unix.tar.gz -O nexus-3.tar.gz
tar xpf nexus-3.tar.gz
mkdir /opt/nexus
mv ./nexus*/* /opt/nexus
mv ./sonatype-work /opt/
ln -s /opt/nexus/bin/nexus /etc/init.d/nexus

cat <<EOT >> nexus.service
[Unit]
Description=nexus service
After=network.target
  
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/etc/init.d/nexus start
ExecStop=/etc/init.d/nexus stop 
User=nexus
Restart=on-abort
TimeoutSec=600
  
[Install]
WantedBy=multi-user.target
EOT

mv ./nexus.service /etc/systemd/system/nexus.service
systemctl daemon-reload
useradd -M -s /bin/bash nexus
chown nexus:nexus -R /var/lib/nexus /opt/nexus /opt/sonatype-work
rm /opt/nexus/bin/nexus.rc
touch /opt/nexus/bin/nexus.rc
echo "run_as_user=\"nexus\"" >> /opt/nexus/bin/nexus.rc
systemctl enable nexus.service --now
rm -rf ./nexus-3*
