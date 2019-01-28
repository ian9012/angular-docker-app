FROM node:alpine as BUILD

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

## use the latest docker image for NGINX
FROM nginx:latest

EXPOSE 80

## Remove default NGINX web files
RUN rm -rf /usr/share/nginx/html/*

COPY --from=BUILD /app/dist/ /usr/share/nginx/html

## Set the permission for NGINX web folder
RUN chmod 777 -R /usr/share/nginx/html

## Overwrit the default NGINX config using the custom config file
#COPY ./custom-nginx-file.conf /etc/nginx/conf.d/default.conf

## Initiate the NGINX
#CMD ["nginx", "-g", "daemon off;"]
