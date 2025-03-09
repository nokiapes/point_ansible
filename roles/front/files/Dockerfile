FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start
RUN mkdir -p /var/www/nginx/point && \
    mkdir -p /var/cache/nginx/client_temp && \
    mkdir -p /var/cache/nginx/proxy_temp && \
    # mkdir -p /var/cache/nginx/fastcgi_temp && \
    # mkdir -p /var/cache/nginx/uwsgi_temp && \
    # mkdir -p /var/cache/nginx/scgi_temp && \
    # mkdir -p /var/log/nginx && \
    # touch /var/log/nginx/error.log && \
    # touch /var/log/nginx/access.log && \

    chown -R nginx:nginx /var/www/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /run/nginx.pid && \
    chown nginx:nginx /run/nginx.pid && \
    # Добавляем: удаляем ненужные файлы
    rm -rf /usr/share/nginx/html/* && \
    # Добавляем: проверку конфигурации
    chmod -R 555 /var/www/nginx/point

WORKDIR /var/www/nginx/point
COPY --from=build /app/dist .
COPY nginx.conf /etc/nginx/conf.d/default.conf 
# ^ host/cont


USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
