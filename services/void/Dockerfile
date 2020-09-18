FROM alpine:latest
LABEL maintainer="Sohel Aman"

RUN apk update
RUN apk add busybox-extras bash fish vim tmux htop git util-linux sudo

## create user - same group name and user name
ARG DOCKER_HOST_USER_ID
ARG DOCKER_HOST_GROUP_ID
ARG DOCKER_HOST_USER
RUN addgroup -g ${DOCKER_HOST_GROUP_ID} ${DOCKER_HOST_USER}
RUN adduser -D -g '' -u ${DOCKER_HOST_USER_ID} -G ${DOCKER_HOST_USER} ${DOCKER_HOST_USER}
RUN echo "${DOCKER_HOST_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${DOCKER_HOST_USER} \
	&& chmod 0440 /etc/sudoers.d/${DOCKER_HOST_USER}

## install programs
RUN apk add python3 py3-pip nodejs npm ruby gcc
RUN apk add php php-pdo_mysql php-mysqli php-pdo_mysql php-xml php-curl php-tokenizer php-dom php-gd php-zip php-bz2 php-pear php-gettext php-fileinfo
RUN apk add nano curl rsync openssh less mtr mlocate entr goaccess jq ranger nethogs bmon youtube-dl aria2 monit httpie fzf fd asciinema exa ncdu p7zip unrar
#RUN apk add vifm ripgrep
RUN apk add mysql-client composer

## npm packages
RUN npm i -g yarn hget express forever nodemon pm2 raml2html tldr
RUN npm i -g --unsafe-perm loadtest
RUN npm i -g webpack webpack-cli parcel-bundler grunt grunt-cli gulp-cli gulp babel-cli @ionic/cli @vue/cli @vue/cli-init firebase-tools
RUN export NG_CLI_ANALYTICS=true && npm i -g @angular/cli

## pip packages
RUN pip3 install virtualenv

## php configs
ARG PHP_INI_FILE=/etc/php7/php.ini
RUN sed -i "s/^memory_limit = .*$/memory_limit = 256M/" ${PHP_INI_FILE} \
    && sed -i "s/^max_execution_time = .*$/max_execution_time = 600/" ${PHP_INI_FILE} \
    && sed -i "s/^error_reporting = .*$/error_reporting = E_ALL/" ${PHP_INI_FILE}

## ibm cloud cli
RUN curl -fsSL https://clis.cloud.ibm.com/install/linux | sh

## heroku cli
RUN curl https://cli-assets.heroku.com/install.sh | sh

## drupalconsole
RUN curl https://drupalconsole.com/installer -L -o drupal.phar \
    && chmod +x drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal

## drush 8
RUN curl https://github.com/drush-ops/drush/releases/download/8.3.5/drush.phar -L -o drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush

## wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -L -o wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

## pantheon terminus
RUN curl https://github.com/pantheon-systems/terminus/releases/download/2.4.0/terminus.phar -L -o terminus.phar \
    && chmod +x terminus.phar \
    && mv terminus.phar /usr/local/bin/terminus

## configs
RUN mkdir -p /root/.config/fish && echo "set fish_greeting" >> /root/.config/fish/config.fish
COPY conf/.tmux.conf /root/.tmux.conf
COPY conf/.vimrc /root/.vimrc
RUN mkdir -p /home/${DOCKER_HOST_USER}/.config/fish && echo "set fish_greeting" >> /home/${DOCKER_HOST_USER}/.config/fish/config.fish
COPY conf/.tmux.conf /home/${DOCKER_HOST_USER}/.tmux.conf
COPY conf/.vimrc /home/${DOCKER_HOST_USER}/.vimrc
RUN chown -R ${DOCKER_HOST_USER}:${DOCKER_HOST_USER} /home/${DOCKER_HOST_USER}

## ports for various usage
EXPOSE 1111 3333 5555 7777

USER ${DOCKER_HOST_USER}

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}
