[DEFAULT]
# "bantime" is the number of seconds that a host is banned.
bantime  = 20m

# A host is banned if it has generated "maxretry" during the last "findtime"
# seconds.
findtime  = 5m

# "maxretry" is the number of failures before a host get banned.
maxretry = 5

# "maxmatches" is the number of matches stored in ticket (resolvable via tag <matches> in actions).
maxmatches = %(maxretry)s

banaction = ufw
banaction_allports = ufw

ignoreip = 127.0.0.1/8 ::1


# JAILS
# security SSH
#
[sshd]
enabled = true
port = 2020
filter = sshd-custom
logpath = /var/log/auth.log
maxretry = 5
findtime = 5m
bantime = 20m
mode = aggressive

# security docker frontend
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
logpath = /var/log/nginx-docker/access.log
          /var/log/nginx/access.log
maxretry = 2
findtime = 10m
bantime = 48h

[nginx-ssl-attacks]
enabled = true
filter = nginx-ssl-attacks
port = http,https
logpath = /var/log/nginx/access.log
          /var/log/nginx/error.log
maxretry = 2
findtime = 20m
bantime = 48h
