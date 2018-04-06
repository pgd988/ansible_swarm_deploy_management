FROM alpine

RUN apk --no-cache add nginx

RUN rm -rf /etc/nginx/*
RUN rm -rf /usr/share/nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY releases/master/* /var/www/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

