FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

ARG USE_BD_MIRRORS=false
RUN if [ ${USE_BD_MIRRORS} = true ]; then \
	sed -i '1s/^/deb\ http\:\/\/mirror\.amberit\.com\.bd\/debian stretch main\n/' /etc/apt/sources.list \
;fi

RUN apt-get update && apt-get install -y lsb-release apt-transport-https ca-certificates bc wget curl vim tmux fish locales

RUN sed -i '/en_US\.UTF\-8\ UTF\-8/s/^#\s*//g' /etc/locale.gen
RUN locale-gen

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update

## PHP versions to install
ARG ADD_PHP_56=false
ARG ADD_PHP_74=false
ARG ADD_PHP_73=false
ARG ADD_PHP_72=false
ARG ADD_PHP_71=false
ARG ADD_PHP_70=false

## Export PHP-FPM versions. This will be used in the scripts later.
ARG FPM_ADD_PHP_VERSIONS=5.6:${ADD_PHP_56};\
7.4:${ADD_PHP_74};\
7.3:${ADD_PHP_73};\
7.2:${ADD_PHP_72};\
7.1:${ADD_PHP_71};\
7.0:${ADD_PHP_70}

ENV FPM_ADD_PHP_VERSIONS=${FPM_ADD_PHP_VERSIONS}

## Auto-configurations
ADD config/php/ini/dockerized-overrides.ini /etc/php/php-overrides.ini
RUN mkdir /root/dockerized
COPY ./config /root/dockerized/config
RUN chmod -R +x /root/dockerized/config/
RUN /root/dockerized/config/php/setup.sh

## Doing it post-install to prevent it installing default php packages as deps.
RUN apt-get install -y composer

## Expose ports
EXPOSE 9056 9070 9071 9072 9073 9074

## Launcher script
COPY launcher.sh /root/
RUN chmod +x /root/launcher.sh

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}

## Bootup
ENTRYPOINT /bin/bash /root/launcher.sh && /bin/bash
