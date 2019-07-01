#!/bin/bash

echo 'Get Dockerized!'

date && hostname -i

service apache2 start

enabled_versions=$(echo ${FPM_INSTALL_PHP_VERSIONS} | tr ";" "\n")
for item in $enabled_versions
do
  ver_enabled=$(echo "$item" | awk -F: '{print $2}' | sed 's/[ \t]\?//g')
  if [ "$ver_enabled" = true ]; then
  	ver_str=$(echo "$item" | awk -F: '{print $1}' | sed 's/[ \t]\?//g')
		service php${ver_str}-fpm start && service php${ver_str}-fpm status
	fi
done
