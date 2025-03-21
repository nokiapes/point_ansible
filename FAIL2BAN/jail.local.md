[DEFAULT]
# Используем UFW для блокировки
banaction = ufw
banaction_allports = ufw

# "maxretry" - количество неудачных попыток до блокировки
maxretry = 5

# "findtime" - время в течение которого ищем "maxretry" попыток
findtime = 5m

# Время блокировки в секундах (по умолчанию 20 минут)
bantime = 20m

# Игнорируемые IP (добавьте ваши доверенные IP)
ignoreip = 127.0.0.1/8 ::1

# security SSH
#
[sshd]
enabled = true
port = 2020
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
findtime = 5m
bantime = 20m


# security docker frontend
#
[nginx-http-auth-docker]
enabled = true
filter = nginx-http-auth
port = http,https
logpath = /var/log/nginx-docker/error.log
# maxretry = 5
# findtime = 3m
# bantime = 20m

[nginx-botsearch-docker]
enabled = true
filter = nginx-botsearch
port = http,https
logpath = /var/log/nginx-docker/access.log
maxretry = 3
findtime = 30m
bantime = 24h


# security nginx-proxy
#
[nginx-http-auth]
enabled = true
filter = nginx-http-auth
port = http,https
logpath = /var/log/nginx/error.log
maxretry = 5
findtime = 10m
bantime = 1h

[nginx-botsearch]
enabled = true
filter = nginx-botsearch
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 2
findtime = 24h
bantime = 48h

[nginx-req-limit]
enabled = true
filter = nginx-limit-req
port = http,https
logpath = /var/log/nginx/error.log
maxretry = 5
findtime = 5m
bantime = 1h

[nginx-403]
enabled = true
filter = nginx-403
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 3
findtime = 10m
bantime = 1h

[nginx-404]
enabled = true
filter = nginx-404
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 7
findtime = 5m
bantime = 6h

[nginx-bad-request]
enabled = true
filter = nginx-bad-request
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 3
findtime = 5m
bantime = 1h

[nginx-empty-agent]
enabled = true
filter = nginx-empty-agent
port = http,https
logpath = /var/log/nginx-docker/access.log /var/log/nginx/access.log
maxretry = 2
findtime = 10m
bantime = 48h

[nginx-ssl-attacks]
enabled = true
filter = nginx-ssl-attacks
port = http,https
logpath = /var/log/nginx/access.log /var/log/nginx/error.log
maxretry = 2
findtime = 20m
bantime = 48h
