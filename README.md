# Supported tags and respective `Dockerfile` links

`v3.3.1` [*(bpodwinski/docker-phpservermon/v3.3.1)*](https://github.com/bpodwinski/docker-phpservermon/tree/v3.3.1)

### What is this ?

PHP Server Monitor is a script that checks whether your websites and servers are up and running. It comes with a web based user interface where you can manage your services and websites, and you can manage users for each server with a mobile number and email address. [official website](http://www.phpservermonitor.org/).

### Features

- Based on Alpine (>50MB!)
- Latest stable versions
- With nginx and PHP7.1

### Ports

- **80**

### Environment

| Variable | Type | Default value |
| -------- | ---- | ------------- |
| **PSM_BASE_URL** | *required* | null
| **PSM_DB_HOST** | *required* | null
| **PSM_DB_PORT** | *optional* | 3306
| **PSM_DB_NAME** | *required* | null
| **PSM_DB_USER** | *required* | null
| **PSM_DB_PASS** | *required* | null
| **PSM_DB_PREFIX** | *required* | null
| **PHP_TIMEZONE** | *optional* | UTC
| **PHP_MEMORY_LIMIT** | *optional* | 256M
| **MAX_UPLOAD** | *optional* | 128M
| **UPDATE_INTERVAL** | *optional* | 300

### Volumes

No volume required!

### Example Docker Compose configuration

```
version: "3"
services:

 db:
  image: mariadb:10
  container_name: phpservermon-mariadb
  hostname: mariadb
  restart: always
  volumes:
   - ./mariadb:/var/lib/mysql
  environment:
   - MYSQL_ROOT_PASSWORD=password
   - MYSQL_DATABASE=phpservermon
   - MYSQL_USER=phpservermon
   - MYSQL_PASSWORD=password

 phpservermon:
  image: benoitpodwinski/phpservermon
  container_name: phpservermon
  hostname: phpservermon
  restart: always
  environment:
   - PSM_BASE_URL=http://website.com/
   - PSM_DB_HOST=db
   - PSM_DB_NAME=phpservermon
   - PSM_DB_USER=phpservermon
   - PSM_DB_PASS=password
   - PSM_DB_PREFIX=Y8ze_
   - PHP_TIMEZONE=Europe/Paris
  depends_on:
   - db
  ports:
   - 80:80
```

### Source
* Image Github: https://github.com/bpodwinski/docker-phpservermon
* PHP Server Monitor Github: https://github.com/phpservermon/phpservermon
* PHP Server Monitor Website: http://www.phpservermonitor.org/
* Fork https://github.com/invartam/Docker-PHPServerMon
