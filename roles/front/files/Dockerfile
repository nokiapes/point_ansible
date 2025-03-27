FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start
RUN apk update && \
    apk upgrade &&\
    apk add --no-cache \
    libxml2 \
    libxslt>=1.1.42-r2 \
    libexpat>=2.7.0-r0 && \
    rm -rf /var/cache/apk/* &&\
    mkdir -p /var/www/nginx/point && \
    # удаляем ненужные файлы
    rm -rf /usr/share/nginx/html/* && \
    # проверка конфигурации
    # chmod -R 755 /var/www/nginx/point

WORKDIR /var/www/nginx/point
COPY --from=build /app/dist .
COPY nginx.conf /etc/nginx/conf.d/default.conf 
# ^ host/cont

RUN chgrp -R nginx /var/www/nginx/point


USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
