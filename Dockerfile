FROM nginx:alpine

WORKDIR /usr/src/app

COPY index.html /usr/share/nginx/html/

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
