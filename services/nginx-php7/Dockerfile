FROM debian:stretch
MAINTAINER Sohel <sohel@example.com>

RUN apt update && \
	apt -y install wget fish vim tmux apt-transport-https lsb-release ca-certificates locales

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update && \
	apt -y install nginx php-xdebug \
	php7.3 php7.3-fpm php7.3-mbstring php7.3-mysql php7.3-zip php7.3-gd php7.3-xml

## Locale
RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
RUN locale-gen

## PHP configurations
#RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ALL/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/memory_limit = .*$/memory_limit = 256M/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/max_execution_time = .*$/max_execution_time = 600/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/upload_max_filesize = .*$/upload_max_filesize = 256M/" /etc/php/7.3/fpm/php.ini
RUN sed -i "s/post_max_size = .*$/post_max_size = 256M/" /etc/php/7.3/fpm/php.ini

## Expose ports
EXPOSE 80

## Remove existing conf
RUN unlink /etc/nginx/sites-enabled/default
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup

## Add and enable nginx default host conf
ADD nginx/default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

## start nginx
ENTRYPOINT date && hostname -i && service nginx start && service php7.3-fpm start && /bin/bash
