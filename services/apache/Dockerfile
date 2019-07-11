FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y wget vim locales curl \
	apt-transport-https lsb-release ca-certificates

## Locale
RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
RUN locale-gen

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

## Install Apache
RUN apt-get update && apt-get install -y apache2 libapache2-mod-fcgid php-xdebug

ARG DEFAULT_PHP_VER=7.3
ENV DEFAULT_PHP_VER=${DEFAULT_PHP_VER}

## PHP versions to install
ARG FPM_INSTALL_PHP_73=false
ARG FPM_INSTALL_PHP_72=false
ARG FPM_INSTALL_PHP_71=false
ARG FPM_INSTALL_PHP_70=false
ARG FPM_INSTALL_PHP_56=false
ARG FPM_INSTALL_PHP_55=false
ARG FPM_INSTALL_PHP_54=false
ARG FPM_INSTALL_PHP_53=false

## Export PHP-FPM versions. This will be used in the scripts later.
ARG FPM_INSTALL_PHP_VERSIONS=5.3:${FPM_INSTALL_PHP_53};\
5.4:${FPM_INSTALL_PHP_54};\
5.5:${FPM_INSTALL_PHP_55};\
5.6:${FPM_INSTALL_PHP_56};\
7.0:${FPM_INSTALL_PHP_70};\
7.1:${FPM_INSTALL_PHP_71};\
7.2:${FPM_INSTALL_PHP_72};\
7.3:${FPM_INSTALL_PHP_73}

ENV FPM_INSTALL_PHP_VERSIONS=${FPM_INSTALL_PHP_VERSIONS}

## Auto-configurations
RUN mkdir /root/dockerized
COPY ./config /root/dockerized/config
RUN chmod -R +x /root/dockerized/config/
RUN /root/dockerized/config/configure.sh

## Apache modules
RUN a2enmod rewrite ssl actions fcgid alias proxy_fcgi

## Default SSL cert
RUN make-ssl-cert generate-default-snakeoil

## Apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

## Expose ports
EXPOSE 80 443

## Apache custom config
ADD apache2/configs/custom.conf /etc/apache2/conf-available/custom.conf
RUN ln -s /etc/apache2/conf-available/custom.conf /etc/apache2/conf-enabled/custom.conf

## Default FPM handler
ADD apache2/configs/fpm-handlers /etc/apache2/conf-available/fpm-handlers/
RUN ln -s /etc/apache2/conf-available/fpm-handlers/fpm-handler-${DEFAULT_PHP_VER}.conf /etc/apache2/conf-enabled/fpm-handler.conf

## Default site
ADD apache2/vhosts/000-default.conf /etc/apache2/sites-available/000-default.conf

## Other virtual hosts
# ADD apache2/vhosts/vhosts.conf /etc/apache2/sites-enabled/vhosts.conf

## Launcher script
COPY launcher.sh /root/
RUN chmod +x /root/launcher.sh

## Bootup
ENTRYPOINT /bin/bash /root/launcher.sh && /bin/bash
