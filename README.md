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

## Installation and Usages
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
- Apache virtual host configs are kept in the `services/apache/conf/vhosts.conf` file. [Examples](services/apache/conf/vhosts.example.conf) are provided.
```
$ cp services/apache/conf/vhosts.example.conf services/apache/conf/vhosts.conf
```
- Similarly, Nginx virtual host configs are kept in the `services/nginx/conf/vhosts.conf` file. [Examples](services/nginx/conf/vhosts.example.conf) are provided.
```
$ cp services/nginx/conf/vhosts.example.conf services/nginx/conf/vhosts.conf
```
- Additional Apache configuration, if necessary, can be put in the [services/apache/conf/dockerized.conf](services/apache/conf/dockerized.conf) file.

### Build images
```
$ sudo docker-compose build fpm apache mariadb
```
Or all,
```
$ sudo docker-compose build
```

### Run service(s)
```
$ sudo docker-compose up -d apache
$ sudo docker-compose start apache
```
Or,
```
$ sudo docker-compose up -d nginx mariadb redis
$ sudo docker-compose start nginx mariadb redis
```

### Execute commands in a container
```
$ sudo docker-compose exec apache bash
```

### Stop service(s)
```
$ sudo docker-compose stop
$ sudo docker-compose stop apache mariadb
$ sudo docker-compose down
```

## Notes
- Images should be rebuilt in case of any modifications in the `.env`, YML, etc.
- Show images
```
$ sudo docker-compose images
```
- Show running containers
```
$ sudo docker-compose ps
```
- Show all containers
```
$ sudo docker ps -a
```
- Container details
```
$ sudo docker inspect container_id
$ sudo docker inspect container_id | grep IP
```
- Remove stopped containers
```
$ sudo docker container prune
```
