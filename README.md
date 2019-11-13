# Dockerized

Get dockerized.

## What's included
A stack of applications put together using Docker solely to ease PHP based web development.

### Services
| Category |             Services              |
|----------|:---------------------------------:|
| Web      | apache, nginx, fpm                |
| Database | mariadb, mysql, postgres, mongodb |
| Caching  | redis, memcached, varnish         |
| Misc     | void, ftp, emby                   |

**PHP versions**
- PHP [packages](https://packages.sury.org/php/) from the [DEB.SURY.ORG](https://deb.sury.org/) repository are used.
- Supported PHP versions: 5.6, 7.0, 7.1, 7.2, and 7.3.

**Additional information**
- The `fpm` service runs the PHP-FPM servers. Apache and Nginx services are dependent on it.
- The `void` service contains generic tools and utilities such as npm, composer, etc.
- The `varnish` service uses `apache` as its backend by default. Backend can be specified in the [default config](services/varnish/config/default.vcl) file.
- I don't know why *PHP based web development* might need the `emby` service for any reason but I put it there anyway. It's like playing god. He does several things that don't make any sense, but he does those anyway. Because, he can.

## Installation
### The repository
```
$ git clone https://github.com/sohelaman/dockerized.git && cd dockerized
```
Every command mentioned beyond this point should be run inside the *dockerized* directory.

### Setting up the environment
- Environment variables reside in the `.env` file at the root. This is necessary and should be copied from the provided `example.env` file.
```
$ cp example.env .env
```
- The `DOCKER_HOST_IP` variable in the `.env` file should point the correct IP of the host in the Docker network stack. Executing the following command will display that IP,
```
$ ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+'
```
- Other changes to the variables inside the `.env` file can be made for additional customization.
- Apache and Nginx virtual host configs need to be kept in the corresponding `conf/vhosts.conf` files. Examples for both [Apache](services/apache/conf/vhosts.example.conf) and [Nginx](services/nginx/conf/vhosts.example.conf) are provided and can be used as boilerplate.
```
$ cp services/apache/conf/vhosts.example.conf services/apache/conf/vhosts.conf
$ cp services/nginx/conf/vhosts.example.conf services/nginx/conf/vhosts.conf
```
- Additional Apache and Nginx configuration, if necessary, can be put in the [services/apache/conf/dockerized.conf](services/apache/conf/dockerized.conf) and [services/nginx/conf/dockerized.conf](services/nginx/conf/dockerized.conf) file. It is important to mention that, for Nginx, the `dockerized.conf` file can only include directives for `http` block only; and must not contain any duplicate directive that already exists under the `http` block in the `/etc/nginx/nginx.conf` file of the container.
- Each PHP version uses a separate *php.ini* file. These files are located in the [services/fpm/config/php/ini](services/fpm/config/php/ini) directory. These files already include a few development friendly configs. Changes made in these files will be reflected in corresponding FPM servers when containers reload.

## Usages
### Building the images
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

## Notes
- Images should be rebuilt in case of any modifications in the `.env`, YML, etc.
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
