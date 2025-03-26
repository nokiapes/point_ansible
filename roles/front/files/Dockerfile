FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start
RUN apk update && \
    apk upgrade libxml2 libxslt libexpat && \
    rm -rf /var/cache/apk/* &&\
    mkdir -p /var/www/nginx/point && \
    # удаляем ненужные файлы
    rm -rf /usr/share/nginx/html/* && \
    # проверка конфигурации
    chmod -R 555 /var/www/nginx/point

WORKDIR /var/www/nginx/point
COPY --from=build /app/dist .
COPY nginx.conf /etc/nginx/conf.d/default.conf 
# ^ host/cont


USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
