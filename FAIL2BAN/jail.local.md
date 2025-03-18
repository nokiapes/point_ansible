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

#
# SSH защита
#
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
findtime = 3m
bantime = 20m

#
# Защита фронтенд-контейнера
#
[nginx-http-auth-docker]
enabled = true
filter = nginx-http-auth
port = http,https
logpath = /var/log/nginx-docker/error.log
maxretry = 5
findtime = 3m
bantime = 20m

[nginx-botsearch-docker]
enabled = true
filter = nginx-botsearch
port = http,https
logpath = /var/log/nginx-docker/access.log
maxretry = 3
findtime = 30m
bantime = 24h

[nginx-badbots-docker]
enabled = true
filter = nginx-badbots
port = http,https
logpath = /var/log/nginx-docker/access.log
maxretry = 3
findtime = 30m
bantime = 24h

[nginx-custom-security-docker]
enabled = true
filter = nginx-custom-security
port = http,https
logpath = /var/log/nginx-docker/access.log
maxretry = 3
findtime = 10m
bantime = 6h

#
# Защита прокси-сервера
#
[nginx-http-auth]
enabled = true
filter = nginx-http-auth
port = http,https
logpath = /var/log/nginx/error.log
maxretry = 3
bantime = 1d

[nginx-botsearch]
enabled = true
filter = nginx-botsearch
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 2
bantime = 2d
findtime = 1h

[nginx-badbots]
enabled = true
filter = nginx-badbots
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 2
bantime = 2d
findtime = 1h

[nginx-req-limit]
enabled = true
filter = nginx-limit-req
port = http,https
logpath = /var/log/nginx/error.log
maxretry = 5
findtime = 5m
bantime = 6h

[nginx-404]
enabled = true
filter = nginx-404
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 10
findtime = 5m
bantime = 12h

[nginx-noscript]
enabled = true
filter = nginx-noscript
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 4
findtime = 1h
bantime = 1d

[nginx-api-abuse]
enabled = true
filter = nginx-api-abuse
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 5
findtime = 10m
bantime = 6h

[nginx-xss-sql]
enabled = true
filter = nginx-xss-sql
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 2
findtime = 10m
bantime = 1d