FROM ubuntu:20.04
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive
# ARG TZ="Asia/Dhaka"

RUN apt-get update
RUN apt-get install -y sudo fish vim tmux htop wget curl git locales lsb-release apt-transport-https ca-certificates software-properties-common gnupg2

## create user - same group name and user name
ARG DOCKER_HOST_USER_ID
ARG DOCKER_HOST_GROUP_ID
ARG DOCKER_HOST_USER
RUN addgroup --gid ${DOCKER_HOST_GROUP_ID} ${DOCKER_HOST_USER}
RUN adduser --disabled-password --gecos '' --uid ${DOCKER_HOST_USER_ID} --gid ${DOCKER_HOST_GROUP_ID} ${DOCKER_HOST_USER}
RUN echo "${DOCKER_HOST_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${DOCKER_HOST_USER} \
    && chmod 0440 /etc/sudoers.d/${DOCKER_HOST_USER}

RUN sed -i '/en_US\.UTF\-8\ UTF\-8/s/^#\s*//g' /etc/locale.gen
RUN locale-gen

## install programs
RUN apt-get install -y gcc python3-pip ruby
RUN apt-get install -y php php-pdo php-mysqli php-mysql php-xml php-curl php-tokenizer php-dom php-gd php-zip php-bz2 php-pear php-fileinfo php-xdebug php-redis
RUN apt-get install -y unzip nano rsync bc iputils-ping openssh-server less mtr mlocate entr goaccess jq nethogs bmon youtube-dl aria2 monit httpie fzf asciinema bat ncdu p7zip unrar figlet vifm ranger
RUN apt-get install -y mysql-client composer
# RUN apt-get install -y fd exa

## nodejs and npm
# RUN apt-get install -y nodejs npm
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh \
    && chmod +x nodesource_setup.sh \
    && ./nodesource_setup.sh \
    && apt-get install -y nodejs

## npm packages
RUN npm i -g yarn hget express forever nodemon pm2 raml2html tldr
RUN npm i -g --unsafe-perm loadtest
RUN npm i -g webpack webpack-cli parcel-bundler grunt grunt-cli gulp-cli gulp babel-cli @ionic/cli @vue/cli @vue/cli-init firebase-tools
RUN export NG_CLI_ANALYTICS=true && npm i -g @angular/cli
RUN npm i -g is-up-cli surge fx serve speed-test overtime-cli

## pip packages
RUN pip3 install virtualenv icdiff

## php configs
ARG PHP_INI_FILE=/etc/php/7.4/cli/php.ini
RUN sed -i "s/^memory_limit = .*$/memory_limit = 256M/" ${PHP_INI_FILE} \
    && sed -i "s/^max_execution_time = .*$/max_execution_time = 600/" ${PHP_INI_FILE} \
    && sed -i "s/^error_reporting = .*$/error_reporting = E_ALL/" ${PHP_INI_FILE}

## add source for kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

## add source for powershell
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && add-apt-repository universe

## install kubectl powershell
RUN apt-get update && apt-get install -y kubectl powershell

## deno
# curl -fsSL https://deno.land/x/install/install.sh | sh && ln -s /root/.deno/bin/deno /usr/local/bin/deno
RUN curl https://github.com/denoland/deno/releases/latest/download/deno-x86_64-unknown-linux-gnu.zip -L -o deno.zip \
    && unzip deno.zip \
    && chmod +x deno \
    && mv deno /usr/local/bin/deno

## ibm cloud cli
RUN curl -fsSL https://clis.cloud.ibm.com/install/linux | sh

## heroku cli
RUN curl https://cli-assets.heroku.com/install.sh | sh

## drupalconsole
RUN curl https://drupalconsole.com/installer -L -o drupal.phar \
    && chmod +x drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal

RUN curl https://github.com/asciimoo/wuzz/releases/download/v0.4.0/wuzz_linux_amd64 -L -o wuzz_linux_amd64 \
    && chmod +x wuzz_linux_amd64 \
    && mv wuzz_linux_amd64 /usr/local/bin/wuzz

## drush 8
RUN curl https://github.com/drush-ops/drush/releases/download/8.4.5/drush.phar -L -o drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush

## wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -L -o wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

## pantheon terminus
RUN curl https://github.com/pantheon-systems/terminus/releases/download/2.4.1/terminus.phar -L -o terminus.phar \
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
EXPOSE 1111 3333 5555 7777 11235 13579 31415

USER ${DOCKER_HOST_USER}

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}
