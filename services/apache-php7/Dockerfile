FROM debian:stretch
MAINTAINER Sohel <sohel@example.com>

RUN apt update && \
	apt -y install wget fish vim tmux apt-transport-https lsb-release ca-certificates locales

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update && \
	apt -y install apache2 libapache2-mod-fcgid php-xdebug libapache2-mod-php7.3 \
	php7.3-fpm php7.3 php7.3-dev php7.3-mbstring php7.3-mysql php7.3-zip php7.3-gd php7.3-xml

## Locale
RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
RUN locale-gen

## Apache mods
RUN a2enmod php7.3 rewrite actions fcgid

## PHP configurations
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.3/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ALL/" /etc/php/7.3/apache2/php.ini
RUN sed -i "s/memory_limit = .*$/memory_limit = 256M/" /etc/php/7.3/apache2/php.ini
RUN sed -i "s/max_execution_time = .*$/max_execution_time = 600/" /etc/php/7.3/apache2/php.ini
RUN sed -i "s/upload_max_filesize = .*$/upload_max_filesize = 256M/" /etc/php/7.3/apache2/php.ini
RUN sed -i "s/post_max_size = .*$/post_max_size = 256M/" /etc/php/7.3/apache2/php.ini

## Apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

## Expose ports
EXPOSE 80

## Apache custom conf
ADD apache2/custom.conf /etc/apache2/conf-available/custom.conf 

## enable custom.conf
RUN ln -s /etc/apache2/conf-available/custom.conf /etc/apache2/conf-enabled/custom.conf 

## default vhost
ADD apache2/vhosts/000-default.conf /etc/apache2/sites-available/000-default.conf

## start apache2
ENTRYPOINT date && hostname -i && service apache2 start && /bin/bash
