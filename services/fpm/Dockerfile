FROM debian:bullseye-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y sudo bc wget curl vim tmux fish locales
RUN apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2

RUN sed -i '/en_US\.UTF\-8\ UTF\-8/s/^#\s*//g' /etc/locale.gen
RUN locale-gen

## Create user - same group name and user name
ARG DOCKER_HOST_USER_ID
ARG DOCKER_HOST_GROUP_ID
ARG DOCKER_HOST_USER
RUN addgroup --gid ${DOCKER_HOST_GROUP_ID} ${DOCKER_HOST_USER}
RUN adduser --disabled-password --gecos '' --uid ${DOCKER_HOST_USER_ID} --gid ${DOCKER_HOST_GROUP_ID} ${DOCKER_HOST_USER}
RUN echo "${DOCKER_HOST_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${DOCKER_HOST_USER} \
	&& chmod 0440 /etc/sudoers.d/${DOCKER_HOST_USER}

## Add PHP repo
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update

## PHP versions to install
ARG ADD_PHP_56=false
ARG ADD_PHP_82=false
ARG ADD_PHP_81=false
ARG ADD_PHP_80=false
ARG ADD_PHP_74=false
ARG ADD_PHP_73=false
ARG ADD_PHP_72=false
ARG ADD_PHP_71=false
ARG ADD_PHP_70=false

## Export PHP-FPM versions. This will be used in the scripts later.
ARG FPM_ADD_PHP_VERSIONS=5.6:${ADD_PHP_56};\
8.2:${ADD_PHP_82};\
8.1:${ADD_PHP_81};\
8.0:${ADD_PHP_80};\
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
RUN apt install -y composer

## Expose ports
EXPOSE 9056 9070 9071 9072 9073 9074 9080 9081 9082

## Launcher script
COPY launcher.sh /root/
RUN chmod +x /root/launcher.sh

# USER ${DOCKER_HOST_USER}	# does not work. /root/launcher.sh silently fails.

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}

## Bootup
ENTRYPOINT /bin/bash /root/launcher.sh && /bin/bash
