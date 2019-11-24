#!/bin/bash

available_versions=$(echo ${FPM_ADD_PHP_VERSIONS} | tr ";" "\n")
for item in $available_versions
do
  is_enabled=$(echo "$item" | awk -F: '{print $2}' | sed 's/[ \t]\?//g')
  if [ "$is_enabled" = true ]; then
  	## Extract version string
  	ver_str=$(echo "$item" | awk -F: '{print $1}' | sed 's/[ \t]\?//g')

  	## Install common extensions
  	common_extensions=(fpm mysql mongo pgsql mbstring zip gd xml redis memcached curl soap odbc bcmath bz2 gettext fileinfo)
  	for ext in "${common_extensions[@]}"; do apt-get install -y php${ver_str}-${ext}; done

  	## Additional PHP configs. Path relative to the parent `configure.sh` script.
    source $(dirname "$0")/php/additional/php-${ver_str}.sh

		## Multiply $ver_str by 10 and add to 9000.
		fpm_port_num=$(expr $(expr "$ver_str"*"10" | bc | cut -d. -f1) + 9000)

		## Bind certain port for this version in the fpm pool.
		sed -i "s/^listen = .*sock$/listen = 0.0.0.0:$fpm_port_num/" /etc/php/${ver_str}/fpm/pool.d/www.conf

		## PHP ini file for this version.
  	ver_ini=/etc/php/${ver_str}/fpm/php.ini

		## Backup php.ini files. Will be mounted by docker compose.
		mv $ver_ini $ver_ini.backup

		## No need to sed/edit php.ini files using following routines anymore.
		## Will mount user editable ini files using docker compose.

		## Update PHP configurations for the version
		# sed -i "s/^display_errors = .*$/display_errors = On/" ${ver_ini}
		# sed -i "s/^error_reporting = .*$/error_reporting = E_ALL/" ${ver_ini}
		# sed -i "s/^memory_limit = .*$/memory_limit = 256M/" ${ver_ini}
		# sed -i "s/^max_execution_time = .*$/max_execution_time = 600/" ${ver_ini}
		# sed -i "s/^upload_max_filesize = .*$/upload_max_filesize = 256M/" ${ver_ini}
		# sed -i "s/^post_max_size = .*$/post_max_size = 256M/" ${ver_ini}
		# sed -i "s/^short_open_tag = Off$/short_open_tag = On/" ${ver_ini}

    ## Xhprof
    # if [[ $ver_str == 7* ]]; then
    #   tideways=/usr/lib/tideways_xhprof/tideways_xhprof-${ver_str}.so
    #   if [ -f "$tideways" ]; then
    #     echo "extension=/usr/lib/tideways_xhprof/tideways_xhprof-${ver_str}.so" >> ${ver_ini}
    #   fi
    # fi

	fi
done
