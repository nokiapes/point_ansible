FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:alpine AS start
COPY --from=build /app/dist /var/www/nginx/point
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
    
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]