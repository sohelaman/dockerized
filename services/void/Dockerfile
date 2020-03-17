FROM alpine:latest
LABEL maintainer="Sohel Aman"

RUN apk update

RUN apk add busybox-extras bash fish vim tmux htop git util-linux
RUN apk add python3 py3-pip nodejs npm ruby gcc
RUN apk add php php-pdo_mysql php-mysqli php-pdo_mysql php-xml php-curl php-tokenizer php-dom php-gd php-zip php-bz2 php-pear php-gettext php-fileinfo
RUN apk add nano curl rsync openssh less mtr nnn mlocate entr goaccess jq ranger nethogs bmon youtube-dl aria2 monit httpie
RUN apk add mysql-client composer

## essential npm packages
RUN npm i -g yarn loadtest hget express forever nodemon pm2
RUN npm i -g webpack webpack-cli parcel-bundler grunt grunt-cli gulp-cli gulp babel-cli @ionic/cli @vue/cli @vue/cli-init firebase-tools
RUN export NG_CLI_ANALYTICS=true && npm i -g @angular/cli

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
RUN curl https://github.com/drush-ops/drush/releases/download/8.3.2/drush.phar -L -o drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush

## wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -L -o wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

## pantheon terminus
RUN curl https://github.com/pantheon-systems/terminus/releases/download/2.3.0/terminus.phar -L -o terminus.phar \
    && chmod +x terminus.phar \
    && mv terminus.phar /usr/local/bin/terminus

## configs
RUN mkdir -p /root/.config/fish && echo "set fish_greeting" >> /root/.config/fish/config.fish
COPY conf/.tmux.conf /root/.tmux.conf
COPY conf/.vimrc /root/.vimrc

## ports for various usage
EXPOSE 1111 3333 5555

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}
