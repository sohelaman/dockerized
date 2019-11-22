#!/bin/bash

## PHP configurations
source $(dirname "$0")/php/php.sh

## base dir
DOCK=/var/www/html/dockerized
if [ -d "$DOCK" ]; then
  rm -rf $DOCK
fi
mkdir $DOCK
cd $DOCK

## download pretty-index
# wget https://raw.githubusercontent.com/sohelaman/pretty-index/master/index.php
git clone https://github.com/sohelaman/pretty-index.git

IDXFILE=/var/www/html/index.php

if [ -f "$IDXFILE" ]; then
  mv $IDXFILE $IDXFILE.backup
fi
if [ -h "$IDXFILE" ]; then
  unlink $IDXFILE
fi

ln -s $DOCK/pretty-index/index.php $IDXFILE

## php info
touch $DOCK/pi.php
echo '<?php phpinfo(); ?>' > $DOCK/pi.php

## download adminer
wget https://www.adminer.org/latest-en.php -O adminer.php

## download opcache gui
wget https://raw.github.com/rlerdorf/opcache-status/master/opcache.php
# wget https://raw.github.com/amnuts/opcache-gui/master/index.php -O opcache-gui.php

## TODO download redis admin

## TODO download memcached admin
