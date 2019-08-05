FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

ARG USE_BD_MIRRORS=false
RUN if [ ${USE_BD_MIRRORS} = true ]; then \
  sed -i '1s/^/deb\ http\:\/\/mirror\.amberit\.com\.bd\/debian stretch main\n/' /etc/apt/sources.list \
;fi

RUN apt-get update && apt-get install -y wget vim

# RUN apt-get install -y locales

## Locale
# RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
# RUN locale-gen
