# Dockerized

Get dockerized.

## Services
- alpine
- apache
- nginx
- mariadb
- mysql
- mongodb
- postgres
- redis
- memcached

**PHP Versions**
- PHP [packages](https://packages.sury.org/php/) from [DEB.SURY.ORG](https://deb.sury.org/) repository are used.
- Supported versions: 5.3, 5.4, 5.5, 5.6, 7.0, 7.1, 7.2, and 7.3.
- The `apache` service can run multiple versions of PHP at a time but the `nginx` service, at this moment, supports any one of the aforementioned versions.

## Installation and Usages
### Clone the repository
```
$ git clone https://github.com/sohelaman/dockerized.git && cd dockerized
```

### Setup environment
- Make a copy of the example.env file as .env for customizations.
```
$ cp example.env .env
```
- Make necessary changes to the variables inside the .env file.
- Apache virtual host configurations are kept in the [services/apache/apache2/vhosts/vhosts.conf](services/apache/apache2/vhosts/vhosts.conf) file.
- Any additional Apache configuration can be put in the [services/apache/apache2/configs/custom.conf](services/apache/apache2/configs/custom.conf) file.

### Build images
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
- Images must be rebuilt in case of any changes made in the .env, YML, or other configuration.
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
