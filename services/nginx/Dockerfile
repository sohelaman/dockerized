FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y wget vim locales apt-transport-https lsb-release ca-certificates

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

## Locale
RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
RUN locale-gen

ARG NGINX_PHP_VER=7.3
ENV NGINX_PHP_VER=${NGINX_PHP_VER}

RUN apt-get update && \
	apt-get install -y nginx php-xdebug \
	php${NGINX_PHP_VER} php${NGINX_PHP_VER}-fpm \
	php${NGINX_PHP_VER}-mbstring php${NGINX_PHP_VER}-mysql \
	php${NGINX_PHP_VER}-zip php${NGINX_PHP_VER}-gd php${NGINX_PHP_VER}-xml

## PHP configurations
# RUN sed -i "s/^short_open_tag = Off$/short_open_tag = On/" /etc/php/${NGINX_PHP_VER}/fpm/php.ini
RUN sed -i "s/^display_errors = .*$/display_errors = On/" /etc/php/${NGINX_PHP_VER}/fpm/php.ini
RUN sed -i "s/^error_reporting = .*$/error_reporting = E_ALL/" /etc/php/${NGINX_PHP_VER}/fpm/php.ini
RUN sed -i "s/^memory_limit = .*$/memory_limit = 256M/" /etc/php/${NGINX_PHP_VER}/fpm/php.ini
RUN sed -i "s/^max_execution_time = .*$/max_execution_time = 600/" /etc/php/${NGINX_PHP_VER}/fpm/php.ini
RUN sed -i "s/^upload_max_filesize = .*$/upload_max_filesize = 256M/" /etc/php/${NGINX_PHP_VER}/fpm/php.ini
RUN sed -i "s/^post_max_size = .*$/post_max_size = 256M/" /etc/php/${NGINX_PHP_VER}/fpm/php.ini

## Expose ports
EXPOSE 80

## Remove existing conf
RUN unlink /etc/nginx/sites-enabled/default
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup

## FPM handlers
ADD nginx/configs/fpm-handlers /etc/nginx/fpm-handlers/

## Add and enable nginx default host conf
ADD nginx/default /etc/nginx/sites-available/default
RUN sed -i "s/<php-version>/${NGINX_PHP_VER}/" /etc/nginx/sites-available/default
RUN sed -i "s/##!!#//" /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

## start nginx
ENTRYPOINT date && hostname -i && service nginx start && service php${NGINX_PHP_VER}-fpm start && /bin/bash
