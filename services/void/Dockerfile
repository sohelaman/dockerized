FROM archlinux/base
MAINTAINER Sohel Aman <sohel@example.com>

## Use BD mirror.
RUN sed -i '1s/^/Server\ \=\ http\:\/\/mirror\.xeonbd\.com\/archlinux\/\$repo\/os\/\$arch\n/' /etc/pacman.d/mirrorlist
RUN pacman -Syy

## Locale
RUN sed -i '/^# en_US.UTF-8 UTF-8$/s/^# //g' /etc/locale.gen
RUN locale-gen

RUN pacman -S --noconfirm vim tmux fish zsh openssh git sudo which awk
RUN pacman -S --noconfirm neofetch

ARG VOID_USER=copernicus
ENV VOID_USER=${VOID_USER}
RUN useradd -rm -g users -G wheel -s $(which fish) ${VOID_USER}
RUN sed -i "s/^# %wheel ALL=(ALL) NOPASSWD: ALL$/%wheel ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers

# RUN pacman -S --noconfirm nodejs npm
# RUN npm i -g yarn webpack grunt gulp babel-cli ionic
# RUN npm i -g @angular/cli

# RUN pacman -S --noconfirm php composer redis

# RUN pacman -S --noconfirm jdk8-openjdk

# RUN pacman -S --noconfirm python
# RUN pacman -S --noconfirm base-devel

# RUN pacman -S --noconfirm ruby
# RUN gem install compass susy breakpoint

# RUN mkdir ~/install && cd ~/install && \
# 	wget https://github.com/drush-ops/drush/releases/download/8.2.3/drush.phar
# RUN chmod +x ~/install/drush.phar && mv ~/install/drush.phar /usr/local/bin/drush

# RUN cd ~/install && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN chmod +x ~/install/wp-cli.phar && mv ~/install/wp-cli.phar /usr/local/bin/wp

USER ${VOID_USER}
WORKDIR /home/${VOID_USER}

# TODO git config
# TODO ruby gems in path

# ENTRYPOINT echo 'Welcome to the void.' date && hostname -i
