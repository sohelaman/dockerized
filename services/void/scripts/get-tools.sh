#!/bin/bash

## base dir
DOCK=/var/www/html/dockerized
IDXFILE=/var/www/html/index.php

if [ -d "$DOCK" ]; then
  mv $DOCK $DOCK-backup-$(date '+%s')
fi
mkdir $DOCK
cd $DOCK

echo "Just don't." > $DOCK/do-not-leave-important-files-here.txt

## put phpinfo
touch $DOCK/pi.php
echo '<?php phpinfo(); ?>' > $DOCK/pi.php

## download pretty-index
git clone https://github.com/sohelaman/pretty-index.git

if [ -f "$IDXFILE" ]; then
  mv $IDXFILE $IDXFILE.backup
fi
if [ -h "$IDXFILE" ]; then
  unlink $IDXFILE
fi

ln -s $DOCK/pretty-index/index.php $IDXFILE

## download adminer
wget https://www.adminer.org/latest-en.php -O adminer.php

## download opcache gui
wget https://raw.github.com/rlerdorf/opcache-status/master/opcache.php
wget https://raw.github.com/amnuts/opcache-gui/master/index.php -O opcache-gui.php

## download phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-all-languages.zip -O phpMyAdmin.zip
unzip phpMyAdmin.zip
mv phpMyAdmin-4.9.1-all-languages phpMyAdmin
rm phpMyAdmin.zip
cp $DOCK/phpMyAdmin/config.sample.inc.php $DOCK/phpMyAdmin/config.inc.php

## download redis admin
git clone https://github.com/erikdubbelboer/phpRedisAdmin.git
cd $DOCK/phpRedisAdmin && composer install && cd $DOCK

## download memcached admin
git clone https://github.com/elijaa/phpmemcachedadmin.git

## download webgrind
git clone https://github.com/jokkedk/webgrind.git
