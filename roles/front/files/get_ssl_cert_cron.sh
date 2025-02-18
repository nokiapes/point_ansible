#!/bin/bash
mkdir -p /etc/letsencrypt
mkdir -p /var/lib/letsencrypt

docker run --rm \
-v "/etc/letsencrypt:/etc/letsencrypt" \
-v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
-p 80:80 \
certbot/certbot certonly --standalone \
--non-interactive --agree-tos \
--email nokiapes1997@gmail.com \
-d point.in.ua

cd /opt/point/cert && docker docker compose restart point-frontend-1