#!/bin/bash

IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
SITES=(site1.com    site2.com   site3.com   site4.com   site5.com)
PORTS=(8081         8082        8083        8084        8085)

apt update
apt install curl gnupg2 ca-certificates lsb-release debian-archive-keyring -y
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
apt update
apt install nginx
systemctl status nginx

apt install iptables-persistent
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -I INPUT -p tcp --dport 22 -j ACCEPT

echo "" > /etc/nginx/sites-available/sites.conf

for (( i=0; i<${#SITES[@]}; i++ ))
do
mkdir -p /var/www/${SITES[$i]}/html
echo "Site $(( $i + 1 ))" > /var/www/${SITES[$i]}/html/index.html
iptables -I INPUT -p tcp --dport ${PORTS[$i]} -j ACCEPT

cat >> /etc/nginx/sites-available/sites.conf << EOF
server {
    listen ${PORTS[$i]};

    server_name $IP);
    root /var/www/${SITES[$i]}/html;

    location / {
        try_files \$uri /index.html;
    }
}

EOF
done


if [ ! -f /etc/nginx/sites-enabled/sites.conf ]; then
    ln -s /etc/nginx/sites-available/sites.conf /etc/nginx/sites-enabled/sites.conf
fi

iptables-save > /etc/iptables/rules.v4

nginx -t
service nginx reload
systemctl restart nginx