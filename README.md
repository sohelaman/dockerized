# Dockerized

Get dockerized.

## What's included
A stack of applications put together using Docker solely to ease web development.
This stack is built keeping one major point in mind, *portability*. Ever wondered, *I wish I could take my environment everywhere, even in my grave*? If yes, welcome abroad!

### Services
| Category |             Services              |
|----------|:---------------------------------:|
| Web      | apache, nginx, fpm                |
| Database | mariadb, mysql, postgres, mongodb |
| Caching  | redis, memcached, varnish         |
| Misc     | void, ftp, emby                   |

**PHP versions**
- PHP [packages](https://packages.sury.org/php/) from the [DEB.SURY.ORG](https://deb.sury.org/) repository are used.
- Supported PHP versions: 5.3, 5.4, 5.5, 5.6, 7.0, 7.1, 7.2, and 7.3.

**Additional information**
- The `fpm` service runs the PHP-FPM servers. Apache and Nginx services are dependent on it.
- The `void` service contains generic tools and utilities such as npm, composer, etc.
- The `varnish` service uses `apache` as its backend by default. Backend can be specified in the [default config](services/varnish/config/default.vcl) file.

## Installation
### Clone the repository
```
$ git clone https://github.com/sohelaman/dockerized.git && cd dockerized
```

### Setup the environment
- Make a copy of the `example.env` file as `.env` for customizations.
```
$ cp example.env .env
```
- Update the `DOCKER_HOST_IP` variable in the `.env` file. To get the docker host IP run the following command,
```
$ ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+'
```
- Make other necessary changes to the variables inside the `.env` file.
- Apache and Nginx virtual host configs need to be kept in the corresponding `conf/vhosts.conf` files. Examples for both [Apache](services/apache/conf/vhosts.example.conf) and [Nginx](services/nginx/conf/vhosts.example.conf) are provided and can be used as boilerplate.
```
$ cp services/apache/conf/vhosts.example.conf services/apache/conf/vhosts.conf
$ cp services/nginx/conf/vhosts.example.conf services/nginx/conf/vhosts.conf
```
- Additional Apache and Nginx configuration, if necessary, can be put in the [services/apache/conf/dockerized.conf](services/apache/conf/dockerized.conf) and [services/nginx/conf/dockerized.conf](services/nginx/conf/dockerized.conf) file. Please note that, for Nginx, the `dockerized.conf` file can only include directives for `http` block only; and must not contain any duplicate directive that already exists under the `http` block in the `/etc/nginx/nginx.conf` file of the container.

## Usages
### Build images
```
$ docker-compose build fpm apache mariadb redis
```

### Start services
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

### Execute commands in a container
```
$ docker-compose exec apache bash
$ docker-compose exec nginx hostname -i
```

### Stop services
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
