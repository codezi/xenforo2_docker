FROM nginx:1.19.6

RUN mkdir -p /var/www/html

WORKDIR "/etc/nginx"

CMD ["nginx", "-g", "daemon off;"]