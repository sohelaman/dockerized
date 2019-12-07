FROM debian:buster-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

ARG USE_BD_MIRRORS=false
RUN if [ ${USE_BD_MIRRORS} = true ]; then \
  sed -i '1s/^/deb\ http\:\/\/mirror\.amberit\.com\.bd\/debian buster main\n/' /etc/apt/sources.list \
;fi

RUN apt-get update && apt-get install -y wget vim

## Test whatever.
