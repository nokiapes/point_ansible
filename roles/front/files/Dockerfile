FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start

#
RUN chown -R nginx:nginx /var/www/nginx
RUN chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /run/nginx.pid
#

WORKDIR /app
COPY --from=build /var/www/nginx/point .
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# COPY --from=build /app/dist /var/www/nginx/point
# COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
