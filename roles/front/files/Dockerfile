FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start
COPY --from=build /app/dist /var/www/nginx/point
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1
    
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]