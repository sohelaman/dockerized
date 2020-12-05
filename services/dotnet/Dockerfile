FROM debian:buster-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

ARG USE_BD_MIRRORS=false
RUN if [ ${USE_BD_MIRRORS} = true ]; then \
  sed -i '1s/^/deb\ http\:\/\/mirror\.amberit\.com\.bd\/debian buster main\n/' /etc/apt/sources.list \
;fi

RUN apt update && apt install -y sudo wget vim apt-transport-https

RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt update
RUN apt install -y dotnet-sdk-5.0
RUN apt install -y nuget

## create user - same group name and user name
ARG DOCKER_HOST_USER_ID
ARG DOCKER_HOST_GROUP_ID
ARG DOCKER_HOST_USER
RUN addgroup --gid $DOCKER_HOST_GROUP_ID $DOCKER_HOST_USER
RUN adduser --disabled-password --gecos '' --uid $DOCKER_HOST_USER_ID --gid $DOCKER_HOST_GROUP_ID $DOCKER_HOST_USER
RUN echo "${DOCKER_HOST_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${DOCKER_HOST_USER} \
    && chmod 0440 /etc/sudoers.d/${DOCKER_HOST_USER}

USER $DOCKER_HOST_USER

EXPOSE 5000 5001

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}
