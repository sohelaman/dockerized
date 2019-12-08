#!/bin/bash

## post-installation tasks

## install oh-my-zsh
cd ~
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --unattended
rm install.sh

## create fish config
# if [ ! -d ~/.config/fish ]; then
#   mkdir -p ~/.config/fish
#   touch ~/.config/fish/config.fish
# fi

## add composer bin to path
echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.zshrc
# echo 'set -gx PATH $PATH ~/.config/composer/vendor/bin' >> ~/.config/fish/config.fish
