# Dockerized

Get dockerized.

## Services
- apache
- nginx
- fpm
- ftp
- mariadb
- mysql
- mongodb
- postgres
- redis
- memcached
- void

**PHP Versions**
- PHP [packages](https://packages.sury.org/php/) from the [DEB.SURY.ORG](https://deb.sury.org/) repository are used.
- Supported versions: 5.3, 5.4, 5.5, 5.6, 7.0, 7.1, 7.2, and 7.3.

**Notes**
- The `fpm` service runs the PHP-FPM servers. Apache and Nginx services are dependent on it.
- The `void` service contains generic tools and utilities such as npm, composer, etc.

## Usages
### Clone the repository
```
$ git clone https://github.com/sohelaman/dockerized.git && cd dockerized
```

### Setup environment
- Make a copy of the `example.env` file as `.env` for customizations.
```
$ cp example.env .env
```
- Update the variable called `DOCKER_HOST_IP` in the `.env` file. To get the docker host IP run,
```
$ ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+'
```
- Make other necessary changes to the variables inside the `.env` file.
- Apache and Nginx virtual hosts are kept in the corresponding `conf/vhosts.conf` file. Examples for both [Apache](services/apache/conf/vhosts.example.conf) and [Nginx](services/nginx/conf/vhosts.example.conf) are provided and can be used as boilerplates.
```
$ cp services/apache/conf/vhosts.example.conf services/apache/conf/vhosts.conf
$ cp services/nginx/conf/vhosts.example.conf services/nginx/conf/vhosts.conf
```
- Additional Apache and Nginx configuration, if necessary, can be put in the [services/apache/conf/dockerized.conf](services/apache/conf/dockerized.conf) and [services/nginx/conf/dockerized.conf](services/nginx/conf/dockerized.conf) file. Please note that, for Nginx, the `dockerized.conf` file can only include directives for `http` block only; and must not contain any duplicate directive that already exists under the `http` block in the `/etc/nginx/nginx.conf` file of the container.

### Build the image(s)
```
$ docker-compose build fpm apache mariadb
```

### Run service(s)
```
$ docker-compose up -d apache
```
Or multiple,
```
$ docker-compose up -d nginx mariadb redis
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

### Stop service(s)
```
$ docker-compose stop apache mariadb
```
Or stop and remove all containers, networks, volumes, and images,
```
$ docker-compose down
```

## Notes
- Images should be rebuilt in case of any modifications in the `.env`, YML, etc.
- Show images
```
$ docker-compose images
```
- Show running containers
```
$ docker-compose ps
```
- Show all containers
```
$ docker ps -a
```
- Container details
```
$ docker inspect container_id
$ docker inspect container_id | grep IP
```
- Remove stopped containers
```
$ docker container prune
```
