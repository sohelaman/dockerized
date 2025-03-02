# dockerized

Get dockerized.

## What's this?
This is essentially a Docker based LAMP stack.

## What's included?
A stack of applications put together solely to ease PHP based web development.

### Services
| Category | Services                                                              |
|----------|-----------------------------------------------------------------------|
| Web      | apache, nginx, fpm                                                    |
| Database | mariadb, mysql, mssql, postgres, mongodb, couchdb, oracle, oracle11g  |
| SDK      | dotnet                                                                |
| Caching  | redis, memcached, varnish                                             |
| Utility  | void, portainer, theia, maildev, ftp, emby, mongo-express             |

**Supported PHP versions: 5.6, 7.0, 7.1, 7.2, 7.3, 7.4, 8.0, 8.1 and 8.2.**


dockerized is inspired from [Laradock](https://laradock.io/) and supports a smaller set of tools but simpler environment.

## Prerequisites
- [Docker](https://docs.docker.com/get-started/) is required. It is important to mention that, some Microsoft Windows editions do not support Docker at all and some Linux kernels may not come with Docker support out of the box.
- [Docker Compose](https://docs.docker.com/compose/install/) is required.
- Basic understanding on the Unix shell or bash commands and LAMP configurations.
- Initial builds will download a great deal of packages from the internet. Unmetered internet connection is recommended.
- Depending on the services chosen to build, about 2 to 5 GB of disk space is required.

## Installation
### The repository
Clone using Git.
```
$ git clone https://github.com/sohelaman/dockerized.git
$ cd dockerized
```
Or, [download](https://github.com/sohelaman/dockerized/archive/master.zip) and extract.
Every command mentioned beyond this point should be run inside the `dockerized` directory.

### Setting up the environment
- The following four files are necessary and steps needed to prepare them are discussed afterwards,
```
/path/to/dockerized/
-- .env
-- conf/
  -- apache-vhosts.conf
  -- nginx-vhosts.conf
  -- php-overrides.ini
```
- Environment variables reside in the `.env` file at the root. This is necessary and should be copied from the provided `example.env` file.
```
$ cp example.env .env
```
- The `DOCKER_HOST_IP` variable in the `.env` file should point the correct IP of the host in the Docker network stack. Executing the following command will display that IP,
```
$ ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+'
```
- For Linux/UNIX systems only, the host user and group should be set using the `DOCKER_HOST_USER`, `DOCKER_HOST_USER_ID`, and `DOCKER_HOST_GROUP_ID` variables. Following commands can be used to determine these,
```
$ whoami    # for DOCKER_HOST_USER
$ id -u     # for DOCKER_HOST_USER_ID
$ id -g     # for DOCKER_HOST_GROUP_ID
```
- The variables inside the `.env` file are self descriptive. Those can be changed per necessity.
- Existing codebase should be pointed as the `DOCUMENT_ROOT`. This directory will be mounted as `/var/www/html` inside the web servers. So, for the virtual host configs, document roots should be pointed with respect to the `/var/www/html` directory. For example, if the existing codebase looks like the following,
```
/home/sohel/sites/
-- mysite1/
-- mysite2/
```
Then the `DOCUMENT_ROOT` should point to `/home/sohel/sites` and document roots of the virtual host configs should be `/var/www/html/mysite1` and `/var/www/html/mysite2` respectively.
- The `conf` directory at the root of this project is for keeping the user configs. Apache and NGINX virtual host configs need to be kept in the `./conf/apache-vhosts.conf` and `./conf/nginx-vhosts.conf` files respectively. Examples for both [Apache](services/apache/conf/vhosts.example.conf) and [NGINX](services/nginx/conf/vhosts.example.conf) are provided.
```
$ cp services/apache/conf/vhosts.example.conf conf/apache-vhosts.conf
$ cp services/nginx/conf/vhosts.example.conf conf/nginx-vhosts.conf
```
- Each PHP version uses a separate *php.ini* file. These files are located in the [./services/fpm/config/php/ini/](services/fpm/config/php/ini) directory. Any changes made in these files will be reflected in corresponding FPM servers. On top of this, overrides will be imposed. All overrides should be kept in the `./conf/php-overrides.ini` file.
```
$ cp services/fpm/config/php/ini/dockerized-overrides.ini conf/php-overrides.ini
```
These overrides will affect all the PHP versions installed.
- MySQL configuration overrides,
```
$ cp services/mysql/config/dockerized-overrides.cnf conf/mysql-overrides.cnf
```
## Usages
### Building the images
*Initial builds will take longer. Please have patience.*
```
$ docker-compose build fpm apache mariadb redis
```

### Starting the services
```
$ docker-compose up -d nginx
```
Or multiple,
```
$ docker-compose up -d apache mariadb redis
```
Or,
```
$ docker-compose start apache
```

### Executing commands in a container
```
$ docker-compose exec apache bash
$ docker-compose exec nginx hostname -i
$ docker-compose exec redis redis-cli
```

### Stopping the services
```
$ docker-compose stop apache mariadb
```
Or stop and remove all containers, networks, volumes, and images,
```
$ docker-compose down
```

## Additional information
- Images should be rebuilt in case of any modifications in the `.env`, YML, etc.
- The `fpm` service runs the PHP-FPM servers. Both the `apache` and `nginx` services are dependent on it.
- The `fpm` service comes with a bunch of PHP extensions preinstalled. However, there is no simpler way to add or remove extensions without manually modifying the installer script or Dockerfile in that service. This has been done intentionally only to keep things simple.
- PHP packages from the [DEB.SURY.ORG](https://deb.sury.org/) repository are used.
- The `varnish` service uses `apache` as its backend by default. Backend can be specified in the [default config](services/varnish/config/default.vcl) file.
- The `./volumes` directory does not contain anything necessary for dockerized. However, application logs, data, caches, shared spaces are kept and mounted inside that directory unless specifically changed in the `.env` file. For instance, MySQL data directory is set to be `./volumes/var/lib/mysql` by default.
- The `dotnet` service includes .NET SDK and runtimes.
- The `mssql` service data is not persistent. *CAUTION!* Data will be lost if the named volume `mssqldata` is removed or reinitiated.
- The `oracle` service data is not persistent. *CAUTION!* Data will be lost if the named volume `oracledata` is removed or reinitiated.
- To reset `oracle` SYS and SYSTEM passwords: `docker exec <container id> resetPassword <new password>`.
- The `maildev` service is an SMTP mail server. *CAUTION!* Maildev storage is not persistent. Emails will be lost if the container restarts.
- The `portainer` service is a management GUI for Docker.
- The `theia` service is a browser based IDE.
- The `gitea` service is a local git server.
  - `THEIA_WORKSPACE` points to the current project (opened at startup).
  - `THEIA_WORKSPACES` should point the directory that contains all the projects.
  - By default, TheiaIDE should be accessible from [http://localhost:3030](http://localhost:3030)
- The `emby` service is for running an Emby media server.
- The `test` service is basically a useless container, only to be used for experiments.
- The `void` service contains several utilities such as,
  - Fish shell
  - Composer
  - MySQL client
  - Drush 8, DrupalConsole, WP-CLI
  - Heroku CLI, IBM Cloud CLI, Pantheon Terminus CLI
  - Deno, NodeJS, NPM, Yarn
  - Webpack, Gulp, Grunt, Parcel, Babel
  - Ionic CLI, Angular CLI, Vue CLI
  - Python 3, PIP
  - Ruby, Gem
  - GoAccess
  - HTTPie

## Default credentials
Otherwise changed in the `.env` file, the following table shows predefined credentials.

| Service       	|    User    	|  Password  	| Admin UI              	                |
|---------------	|:----------:	|:----------:	|------------------------------------	    |
| ftp           	|    john    	|     doe    	| -                     	                |
| portainer     	|      -     	|      -     	| http://localhost:9900 	                |
| maildev       	|      -     	|      -     	| http://localhost:8088 	                |
| mysql/mariadb 	|    root    	|    root    	| -                     	                |
| mysql/mariadb 	| dockerized 	| dockerized 	| -                     	                |
| mssql           |     sa     	| D0ckerized 	| -                     	                |
| oracle          | system,sys  |   oracle  	| SID: FREE                                 |
| oracle21c       |   system    |   oracle  	| SID: XE                                 |
| oracle11g       |   system    |   oracle  	| SID: XE                                 |
| oracle11g       |   ADMIN     |   admin   	| http://localhost:1515/apex/apex_admin   |
| postgres      	|    root    	|    root    	| -                     	                |
| couchdb       	|    root    	|    root    	| http://localhost:5984 	                |
| mongodb        	|    root    	|    root    	| -                     	                |
| mongo-express 	|      -     	|      -     	| http://localhost:8081 	                |
| gitea          	|      -     	|      -     	| http://localhost:10080 	                |
| emby          	|      -     	|      -     	| http://localhost:8096 	                |


## Default port map
The following table shows ports used. If a service does not expose its port, then it is not accessible from the outside (i.e. from the docker host).

| Service       	| Exposed Ports   	| Internal Ports  	| Purpose       	|
|---------------	|:---------------:	|:---------------:	|---------------	|
| fpm           	|         -       	|       90XX      	| App           	|
| apache        	|      80, 443    	|      80, 443    	| App           	|
| nginx         	|      80, 443    	|      80, 443    	| App           	|
| dotnet         	|    5000, 5001    	|    5000, 5001    	| App           	|
| mysql         	|       3306      	|       3306      	| App           	|
| mariadb       	|       3306      	|       3306      	| App           	|
| mssql         	|       1433      	|       1433      	| App           	|
| oracle         	|       1521      	|       1521      	| App           	|
| oracle21c       |       1521      	|       1521      	| App           	|
| oracle11g     	|    49161, 1515    |    1521, 8080     | App, Admin UI   |
| postgres      	|        -        	|       5432      	| App           	|
| couchdb       	|       5984      	|       5984      	| App, Admin UI 	|
| mongodb        	|        -        	|       27017     	| App           	|
| mongo-express 	|       8081      	|       8081      	| Admin UI      	|
| redis         	|       6379      	|       6379      	| App           	|
| memcached     	|      11211      	|       11211     	| App           	|
| varnish       	|       8080      	|       8080      	| App           	|
| ftp           	|        -        	|      20, 21     	| App           	|
| maildev       	|       8088      	|        80       	| Admin UI      	|
| maildev       	|        -        	|        25       	| SMTP          	|
| emby          	|    8096, 8920   	|    8096, 8920   	| Admin UI      	|
| gitea          	|   10080, 10022    |     3000, 22    	| Admin UI, SSH   |
| portainer     	|       9900      	|       9000      	| Admin UI      	|
| theia          	|       3030      	|       3000      	| App           	|
| void          	| 1111, 3333, 5555  | 1111, 3333, 5555  | Any           	|


## Useful commands
- Show all the images,
```
$ docker-compose images
```
- Show running containers,
```
$ docker-compose ps
```
- Show all containers,
```
$ docker ps -a
```
- Container details,
```
$ docker inspect container_id
$ docker inspect container_id | grep IP
```
- Remove stopped containers or volumes,
```
$ docker container prune
$ docker volume prune
```
- Ollama run a model,
```
$ docker compose exec ollama ollama pull deepseek-r1
$ docker compose exec ollama ollama run deepseek-r1
```

## Todo
- Tested only on 64 bit Linux systems. Testing needed on Microsoft Windows and Apple MacOS.
