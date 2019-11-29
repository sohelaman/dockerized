FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

ARG USE_BD_MIRRORS=false
RUN if [ ${USE_BD_MIRRORS} = true ]; then \
	sed -i '1s/^/deb\ http\:\/\/mirror\.amberit\.com\.bd\/debian stretch main\n/' /etc/apt/sources.list \
;fi

RUN apt-get update && apt-get install -y git wget curl bc vim apt-transport-https lsb-release ca-certificates

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update

## PHP versions to install
ARG ADD_PHP_73=false
ARG ADD_PHP_72=false
ARG ADD_PHP_71=false
ARG ADD_PHP_70=false
ARG ADD_PHP_56=false

## Export PHP-FPM versions. This will be used in the scripts later.
ARG FPM_ADD_PHP_VERSIONS=5.6:${ADD_PHP_56};\
7.0:${ADD_PHP_70};\
7.1:${ADD_PHP_71};\
7.2:${ADD_PHP_72};\
7.3:${ADD_PHP_73}

ENV FPM_ADD_PHP_VERSIONS=${FPM_ADD_PHP_VERSIONS}

## Auto-configurations
RUN mkdir /root/dockerized
COPY ./config /root/dockerized/config
RUN chmod -R +x /root/dockerized/config/
RUN /root/dockerized/config/configure.sh

## Install tideways xhprof extension
RUN curl -O -L https://github.com/tideways/php-xhprof-extension/releases/download/v5.0.1/tideways-xhprof_5.0.1_amd64.deb
RUN dpkg -i tideways-xhprof_5.0.1_amd64.deb

## Expose ports
EXPOSE 9056 9070 9071 9072 9073

## Launcher script
COPY launcher.sh /root/
RUN chmod +x /root/launcher.sh

## Bootup
ENTRYPOINT /bin/bash /root/launcher.sh && /bin/bash
