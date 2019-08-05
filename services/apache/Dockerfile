FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget vim ca-certificates

## Install Apache
RUN apt-get update && apt-get install -y apache2 libapache2-mod-fcgid

ARG APACHE_PHP_VER=7.3
ENV APACHE_PHP_VER=${APACHE_PHP_VER}

## Apache modules
RUN a2enmod rewrite ssl actions fcgid alias proxy_fcgi headers

## Default SSL cert
RUN make-ssl-cert generate-default-snakeoil

## Default FPM handler
ADD conf/fpm-handlers /etc/apache2/conf-available/fpm-handlers/
RUN ln -s /etc/apache2/conf-available/fpm-handlers/fpm-handler-${APACHE_PHP_VER}.conf /etc/apache2/conf-enabled/fpm-handler.conf

## SSL keys
ADD conf/ssl-snakeoil.conf /etc/apache2/conf-available/ssl-snakeoil.conf

## Default site
ADD conf/000-default.conf /etc/apache2/sites-available/000-default.conf

## Apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

## Expose ports
EXPOSE 80 443

## Bootup
ENTRYPOINT date && hostname -i && service apache2 start && /bin/bash
