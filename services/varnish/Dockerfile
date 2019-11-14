FROM debian:buster-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

## Install Varnish.
RUN apt-get update && apt-get install -y varnish nano

## Backup default config.
RUN mv /etc/varnish/default.vcl /etc/varnish/default.vcl.backup

## Port that varnish will listen to.
ARG VARNISH_PORT=8080
ENV VARNISH_PORT=${VARNISH_PORT}

## Expose ports
EXPOSE ${VARNISH_PORT}

## Bootup
ENTRYPOINT varnishd -f /etc/varnish/default.vcl -a ":${VARNISH_PORT}" && /bin/bash
