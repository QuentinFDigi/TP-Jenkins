FROM nginx:alpine

WORKDIR /usr/src/app

COPY index.html /usr/share/nginx/html/index.html
