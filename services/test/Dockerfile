#FROM ubuntu:jammy
FROM debian:bullseye
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y sudo wget vim lsb-release ca-certificates apt-transport-https software-properties-common gnupg2

## debian only
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update

## create user - same group name and user name
ARG DOCKER_HOST_USER_ID
ARG DOCKER_HOST_GROUP_ID
ARG DOCKER_HOST_USER
RUN addgroup --gid $DOCKER_HOST_GROUP_ID $DOCKER_HOST_USER
RUN adduser --disabled-password --gecos '' --uid $DOCKER_HOST_USER_ID --gid $DOCKER_HOST_GROUP_ID $DOCKER_HOST_USER
RUN echo "${DOCKER_HOST_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${DOCKER_HOST_USER} \
    && chmod 0440 /etc/sudoers.d/${DOCKER_HOST_USER}

USER $DOCKER_HOST_USER

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}

## Test whatever.
