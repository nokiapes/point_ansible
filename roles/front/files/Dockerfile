FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start
RUN apk update && \
    apk upgrade --no-cache &&\
    apk add --no-cache \
    libxml2 \
    libxslt>=1.1.42-r2 \
    libexpat>=2.7.0-r0 && \
    rm -rf /var/cache/apk/* &&\
    mkdir -p /var/www/nginx/point && \
    rm -rf /usr/share/nginx/html/* && \
    chmod -R 755 /var/www/nginx/point

WORKDIR /var/www/nginx/point
COPY --from=build /app/dist .
COPY nginx.conf /etc/nginx/conf.d/default.conf 
RUN chown -R nginx:nginx /var/www/nginx/point
# RUN chgrp -R nginx /var/www/nginx/point

USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
