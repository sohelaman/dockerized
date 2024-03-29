FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y nginx vim

ARG NGINX_PHP_VER=8.2
ENV NGINX_PHP_VER=${NGINX_PHP_VER}

## Remove existing conf
RUN unlink /etc/nginx/sites-enabled/default
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup

## FPM handlers
ADD conf/fpm-handlers /etc/nginx/fpm-handlers/

## Default SSL cert
RUN apt-get install -y ca-certificates ssl-cert dialog
RUN make-ssl-cert generate-default-snakeoil
## SSL config
ADD conf/ssl-snakeoil.conf /etc/nginx/ssl-snakeoil.conf

## Add and enable nginx default host conf
ADD conf/default /etc/nginx/sites-available/default
RUN sed -i "s/<php-version>/${NGINX_PHP_VER}/" /etc/nginx/sites-available/default
RUN sed -i "s/##!!#//" /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

## Expose ports
EXPOSE 80 443

## start nginx
ENTRYPOINT date && hostname -i && service nginx start && /bin/bash
