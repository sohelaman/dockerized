FROM debian:stretch-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget vim

# RUN apt-get install -y locales

## Locale
# RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
# RUN locale-gen
