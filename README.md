Эта роль предназначена для разворачивания "Point" проета на сервере с помощью CI/CD jenkins.
Предварительно должно быть:
1) сервер Ububntu 22.04 LTS 
2) установлена java 17 - для подключения сервера как агента jenkins
3) пользователь "jenkins" с доступом к правам "sudo"
4) установлен Docker, Docker compose, Ansible


# настройка file2ban
nginx-http-auth     для защиты от атак на авторизацию
nginx-botsearch     для защиты от сканеров
nginx-badbots       для защиты от вредоносных ботов
# копируем файл /etc/fail2ban/jail.conf в /etc/fail2ban/jail.local и вносим такие правки
cd /etc/fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
nano jail.local

# в начало где [DEFAULT] нужно установить то что мы будем использовать ufw для блокировки

[DEFAULT]
banaction = ufw
banaction_allports = ufw

maxretry = 5
findtime = 5m
bantime = 20m

# Игнорировать локальные адреса
ignoreip = 127.0.0.1/8 ::1



# стандартные
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
findtime = 3m
bantime = 20m

[nginx-http-auth]
enabled = true
filter = nginx-http-auth
port = http,https
logpath = /var/log/nginx-docker/error.log
maxretry = 5
findtime = 3m
bantime = 20m

[nginx-botsearch]
enabled = true
filter = nginx-botsearch
port = http,https
logpath = /var/log/nginx-docker/access.log
maxretry = 3
findtime = 30m
bantime = 24h

[nginx-badbots]
enabled = true
filter = nginx-badbots
port = http,https
logpath = /var/log/nginx-docker/access.log
maxretry = 3
findtime = 30m
bantime = 24h


# кастомные мои
[nginx-custom-security]
enabled = true
filter = nginx-custom-security
port = http,https
logpath = /var/log/nginx-docker/access.log
maxretry = 3
findtime = 10m
bantime = 6h


# добавляем новый фильтр в /etc/fail2ban/filter.d/nginx-custom-security.conf
nano ./filter.d/nginx-custom-security.conf

[Definition]
failregex = ^<HOST> - .* "(GET|POST|HEAD) /(wp-admin|wp-login|wordpress|wp-content|wp-includes|administrator|phpmyadmin|pma|myadmin|mysql|database|cms|cpanel|webmail|mail|smtp|webdav|config|install|setup|backup|old|bak|temp|tmp|cgi-bin|manager|console|api/swagger|api/docs|actuator|solr|jenkins).*" (404|403|400)
ignoreregex =




# Настройка ротации логов из докер контейнеров
/etc/logrotate.d/docker-containers

/var/log/nginx-docker/*.log {
    daily           # Выполнять ротацию ежедневно
    missingok       # Не выдавать ошибку, если файл лога отсутствует
    rotate 7        # Хранить 7 старых версий логов
    compress        # Сжимать старые логи
    delaycompress   # Не сжимать последний ротированный лог
    notifempty      # Не ротировать пустые файлы
    create 0644 nginx nginx # Создавать новые файлы с правами и владельцем
    sharedscripts   # Выполнять скрипты только один раз для всех логов
    postrotate      # Команда, выполняемая после ротации
        docker exec $(docker ps -qf "name=point-frontend-1") nginx -s reopen
    endscript
}


# проверяем конфигурацию и запускаем
sudo fail2ban-client -t
sudo systemctl restart fail2ban
sudo fail2ban-client status