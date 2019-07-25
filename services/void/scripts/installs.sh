#!/bin/bash

## Python tools TODO
if [ "$VOID_ADD_PYTHON" = true ]; then
  # pip install virtualenv
fi

## NPM CLI tools
if [ "$VOID_ADD_NODEJS" = true ]; then
  npm i -g yarn webpack grunt grunt-cli gulp-cli gulp babel-cli ionic foundation-cli
  # npm i -g @angular/cli
fi

## Drush 8
if [ "$VOID_ADD_DRUSH" = true ]; then
  cd ~
  curl https://github.com/drush-ops/drush/releases/download/8.2.3/drush.phar -L -o drush.phar
  chmod +x ~/drush.phar && mv ~/drush.phar /usr/local/bin/drush
fi

## WP-CLI
if [ "$VOID_ADD_WPCLI" = true ]; then
  cd ~
  curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -L -o wp-cli.phar
  chmod +x ~/wp-cli.phar && mv ~/wp-cli.phar /usr/local/bin/wp
fi

## Drupalconsole
if [ "$VOID_ADD_DRUPALCONSOLE" = true ]; then
  cd ~
  curl https://drupalconsole.com/installer -L -o drupal.phar
  chmod +x ~/drupal.phar && mv ~/drupal.phar /usr/local/bin/drupal
fi
