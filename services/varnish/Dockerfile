FROM debian:buster-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

## Install Varnish.
RUN apt-get update && apt-get install -y varnish vim procps

## Backup default config.
RUN mv /etc/varnish/default.vcl /etc/varnish/default.vcl.backup

## Port that varnish will listen to.
ARG VARNISH_PORT=8080
ENV VARNISH_PORT=${VARNISH_PORT}

## Memory allocation.
ARG VARNISH_MALLOC=128M
ENV VARNISH_MALLOC=${VARNISH_MALLOC}

## Expose ports
EXPOSE ${VARNISH_PORT}

## Bootup
ENTRYPOINT varnishd -f /etc/varnish/default.vcl -a ":${VARNISH_PORT}" -s "malloc,${VARNISH_MALLOC}" && /bin/bash
