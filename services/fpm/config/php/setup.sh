#!/bin/bash

## Install selected versions of php with extensions.
available_versions=$(echo ${FPM_ADD_PHP_VERSIONS} | tr ";" "\n")
for item in $available_versions; do
	is_enabled=$(echo "$item" | awk -F: '{print $2}' | sed 's/[ \t]\?//g')

	if [ "$is_enabled" = true ]; then
		## Extract version string
		ver_str=$(echo "$item" | awk -F: '{print $1}' | sed 's/[ \t]\?//g')

		## Install php extensions
		if [[ "$ver_str" == "8.2" || "$ver_str" == "8.1" || "$ver_str" == "8.0" ]]; then
			php_extensions=(cli fpm common mysql pgsql opcache mbstring zip gd xml curl soap odbc bcmath bz2 intl readline ldap)
		else
			php_extensions=(cli fpm common mysql pgsql opcache mbstring zip gd xml curl json soap odbc bcmath bz2 intl readline ldap)
		fi

		for ext in "${php_extensions[@]}"; do apt-get install -y php${ver_str}-${ext}; done

		## Additional PHP configs. Path relative to the parent `setup.sh` script.
		source $(dirname "$0")/additional/php-${ver_str}.sh

		## Multiply $ver_str by 10 and add to 9000.
		fpm_port_num=$(expr $(expr "$ver_str"*"10" | bc | cut -d. -f1) + 9000)

		## Bind certain port for this version in the fpm pool.
		sed -i "s/^listen = .*sock$/listen = 0.0.0.0:$fpm_port_num/" /etc/php/${ver_str}/fpm/pool.d/www.conf

		## PHP ini file for this version.
		ver_ini=/etc/php/${ver_str}/fpm/php.ini

		## Backup php.ini files. Will be mounted by docker compose.
		mv $ver_ini $ver_ini.backup

		## Additional php.ini overrides.
		ln -s /etc/php/php-overrides.ini /etc/php/${ver_str}/fpm/conf.d/90-dockerized-overrides.ini
	fi
done

## Install common extensions for all versions.
common_extensions=(xdebug redis memcached mongodb pear imagick)
for ext in "${common_extensions[@]}"; do apt-get install -y php-${ext}; done
