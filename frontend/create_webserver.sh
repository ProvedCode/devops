#!/bin/bash

IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
SITES=(site1.com    site2.com   site3.com   site4.com   site5.com)
PORTS=(8081         8082        8083        8084        8085)

apt update
apt install nginx -y
systemctl status nginx
apt install ufw -y
echo "y" | sudo ufw enable
ufw allow OpenSSH
ufw allow 'Nginx HTTP'
ufw status

echo "" > /etc/nginx/sites-available/sites.conf

for (( i=0; i<${#SITES[@]}; i++ ))
do
mkdir -p /var/www/${SITES[$i]}/html
echo "Site $(( $i + 1 ))" > /var/www/${SITES[$i]}/html/index.html
ufw allow ${PORTS[$i]}

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

nginx -t
service nginx reload
systemctl restart nginx

