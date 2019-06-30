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
- Supported versions 5.4, 5.5, 5.6, 7.1, 7.2, 7.3.
- The `apache` service runs multiple versions at a time but `nginx`, atm, supports any one at a time.

## Clone the repository
```
$ git clone https://github.com/sohelaman/dockerized.git && cd dockerized
```

## Setup environment
- Make a copy of the example.env file as .env
```
$ cp example.env .env
```
- Make necessary changes to the variables inside the .env file

## Build
```
$ sudo docker-compose build
```

## Run service(s)
```
$ sudo docker-compose up -d apache
$ sudo docker-compose start apache
```
Or,
```
$ sudo docker-compose up -d nginx mariadb redis
$ sudo docker-compose start nginx mariadb redis
```

## Execute commands in a container
```
$ sudo docker-compose exec apache bash
```

## Stop service(s)
```
$ sudo docker-compose stop
$ sudo docker-compose down
```

## Notes
- Show running containers
```
$ sudo docker-compose ps
```
- Show images
```
$ sudo docker-compose images
```
- Images must be rebuilt in case of any changes made in the .env, YML, or other configuration.
