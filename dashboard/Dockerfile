# build stage
FROM node:18.12.1-alpine3.16 AS build-stage
WORKDIR /app
# ENV CHOKIDAR_USEPOLLING=true
COPY package.json .
RUN npm install
COPY . .
# RUN npm install
RUN npm build

# deploy stage
FROM nginx:stable-alpine as deploy-stage
RUN ls -la
COPY ./nginx/dashboard.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]