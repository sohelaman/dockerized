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
ARG VOID_ADD_DEVEL=false
ENV VOID_ADD_DEVEL=${VOID_ADD_DEVEL}
RUN if [ ${VOID_ADD_DEVEL} = true ]; then \
  pacman -S --noconfirm base-devel \
;fi

## various useful packages
RUN pacman -S --noconfirm vim tmux fish zsh openssh git sudo which awk wget unzip tar htop iputils xsel rsync bat cmatrix neofetch mlocate jq nethogs stress
RUN pacman -S --noconfirm php apache mariadb-clients goaccess

ARG VOID_USER=copernicus
ENV VOID_USER=${VOID_USER}
RUN useradd -rm -g users -G wheel -s $(which fish) ${VOID_USER}
RUN sed -i "s/^# %wheel ALL=(ALL) NOPASSWD: ALL$/%wheel ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers

## nodejs, npm, and others
ARG VOID_ADD_NODEJS=false
ENV VOID_ADD_NODEJS=${VOID_ADD_NODEJS}
RUN if [ ${VOID_ADD_NODEJS} = true ]; then \
  pacman -S --noconfirm nodejs npm \
;fi


## php composer
ARG VOID_ADD_COMPOSER=false
ENV VOID_ADD_COMPOSER=${VOID_ADD_COMPOSER}
RUN if [ ${VOID_ADD_COMPOSER} = true ]; then \
  pacman -S --noconfirm php composer redis \
;fi

## java JDK
ARG VOID_ADD_JDK=false
ENV VOID_ADD_JDK=${VOID_ADD_JDK}
ARG VOID_JDK_VERSION=8
ENV VOID_JDK_VERSION=${VOID_JDK_VERSION}
RUN if [ ${VOID_ADD_JDK} = true ]; then \
  pacman -S --noconfirm jdk${VOID_JDK_VERSION}-openjdk \
;fi

## python and pip
ARG VOID_ADD_PYTHON=false
ENV VOID_ADD_PYTHON=${VOID_ADD_PYTHON}
RUN if [ ${VOID_ADD_PYTHON} = true ]; then \
  pacman -S --noconfirm python python-pip \
;fi

## ruby and gem
ARG VOID_ADD_RUBY=false
ENV VOID_ADD_RUBY=${VOID_ADD_RUBY}
RUN if [ ${VOID_ADD_RUBY} = true ]; then \
  pacman -S --noconfirm ruby rubygems \
;fi

## drush
ARG VOID_ADD_DRUSH=false
ENV VOID_ADD_DRUSH=${VOID_ADD_DRUSH}

## wp-cli
ARG VOID_ADD_WPCLI=false
ENV VOID_ADD_WPCLI=${VOID_ADD_WPCLI}

## drupalconsole
ARG VOID_ADD_DRUPALCONSOLE=false
ENV VOID_ADD_DRUPALCONSOLE=${VOID_ADD_DRUPALCONSOLE}

## additional installation
COPY scripts/installs.sh /root/installs.sh
RUN chmod +x /root/installs.sh
RUN /root/installs.sh
RUN rm /root/installs.sh

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

# ENTRYPOINT fish
