FROM archlinux/base
LABEL maintainer="Sohel Aman"

ARG USE_BD_MIRRORS=false
RUN if [ ${USE_BD_MIRRORS} = true ]; then \
  ## use BD mirror.
  sed -i '1s/^/Server\ \=\ http\:\/\/mirror\.xeonbd\.com\/archlinux\/\$repo\/os\/\$arch\n/' /etc/pacman.d/mirrorlist \
;fi

## Sync pacman
RUN pacman -Syy

## update system
RUN pacman -Syu --noconfirm

## locale
RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
RUN locale-gen

## install base-devel
# RUN pacman -S --noconfirm base-devel

## some useful packages
RUN pacman -S --noconfirm which awk iputils sudo wget unzip tar rsync openssh
RUN pacman -S --noconfirm vim tmux fish zsh git htop xsel bat cmatrix mlocate jq nethogs bmon
RUN pacman -S --noconfirm powerline powerline-fonts powerline-vim
RUN pacman -S --noconfirm php apache mariadb-clients goaccess composer

## add user
ARG VOID_USER=copernicus
RUN useradd -rm -g users -G wheel -s $(which bash) ${VOID_USER}
RUN sed -i "s/^# %wheel ALL=(ALL) NOPASSWD: ALL$/%wheel ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers

## php configs
ARG PHP_INI_FILE=/etc/php/php.ini
RUN sed -i "s/^;extension=mysqli$/extension=mysqli/" ${PHP_INI_FILE} \
    && sed -i "s/^;extension=pdo_mysql$/extension=pdo_mysql/" ${PHP_INI_FILE} \
    && sed -i "s/^memory_limit = .*$/memory_limit = 256M/" ${PHP_INI_FILE} \
    && sed -i "s/^max_execution_time = .*$/max_execution_time = 600/" ${PHP_INI_FILE} \
    && sed -i "s/^error_reporting = .*$/error_reporting = E_ALL/" ${PHP_INI_FILE}

## python and pip
RUN pacman -S --noconfirm python python-pip
RUN pip install virtualenv

## nodejs, npm, and others
RUN pacman -S --noconfirm nodejs npm
RUN npm i -g yarn webpack parcel-bundler grunt grunt-cli gulp-cli gulp babel-cli ionic foundation-cli

## ruby and gem
RUN pacman -S --noconfirm ruby rubygems

## java JDK
ARG VOID_JDK_VERSION=8
RUN pacman -S --noconfirm jdk${VOID_JDK_VERSION}-openjdk

## laravel
RUN composer global require laravel/installer

## drupalconsole
RUN curl https://drupalconsole.com/installer -L -o drupal.phar \
    && chmod +x drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal

## drush latest [conflict]
# RUN composer global require drush/drush

## drush 8
RUN curl https://github.com/drush-ops/drush/releases/download/8.3.2/drush.phar -L -o drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush

## wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -L -o wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

## post-installation
COPY scripts/post-install.sh /root/post-install.sh
RUN chmod +x /root/post-install.sh
RUN /root/post-install.sh
RUN rm /root/post-install.sh

## clean pacman caches
RUN pacman --noconfirm -Scc

## user and working dir
# USER ${VOID_USER}
# WORKDIR /home/${VOID_USER}

ARG DOCUMENT_ROOT=/var/www/html
WORKDIR ${DOCUMENT_ROOT}

# TODO dotfiles
# TODO git config
# TODO ssh keys
# TODO ruby gems path
