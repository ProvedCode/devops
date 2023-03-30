#!/bin/bash

IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
FOLDERS=(dmytro-team   maksym-team   oleksandr-team  olha-team   vladyslav-team)
PORTS=(8081         8082        8083        8084        8085)
DOMENS=(provedcode.pepega.cloud starlight.pepega.cloud uptalent.pepega.cloud talantino.pepega.cloud skillscope.pepega.cloud)

for (( i=0; i<${#SITES[@]}; i++ ))
do
cat >> /etc/nginx/conf.d/sites.conf << EOF
server {
    listen ${PORTS[$i]};
    server_name $IP;
    root /var/www/${FOLDERS[$i]}/html;
    location / {
        try_files \$uri /index.html;
    }
}

server {
    listen 80;
    server_name dev.${DOMENS[$i]};
    root /var/www/${FOLDERS[$i]}/html;
    location / {
        try_files \$uri /index.html;
    }
}

server {
    listen 80;
    server_name ${DOMENS[$i]};
    root /var/www/${FOLDERS[$i]}-production/html;
    location / {
        try_files \$uri /index.html;
    }
}

EOF
done

nginx -t
service nginx reload
systemctl restart nginx