FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start
RUN mkdir -p /var/www/nginx/point && \
    mkdir -p /etc/letsencrypt && \
    chown -R nginx:nginx /var/www/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /run/nginx.pid && \
    chown nginx:nginx /run/nginx.pid &&\
    chown nginx:nginx /etc/letsencrypt

WORKDIR /var/www/nginx/point
COPY --from=build /app/dist .
COPY nginx.conf /etc/nginx/conf.d/default.conf 
# ^ host/cont
# COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf 

USER nginx
EXPOSE 81
CMD ["nginx", "-g", "daemon off;"]
