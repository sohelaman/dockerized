# Dockerized

Get dockerized.

## Services
- alpine
- apache-php7
- apache-php5
- mariadb
- mysql
- redis
- phpmyadmin

## Setup environment
- Make a copy of the example.env file as .env
```
$ cd dockerized
$ cp example.env .env
```
- Make necessary changes to the variables inside the .env file

## Run service(s)
```
$ sudo docker-compose run apache-php7
```
Or,
```
$ sudo docker-compose run apache-php5 mariadb redis
```

## Stop all and remove images
```
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
