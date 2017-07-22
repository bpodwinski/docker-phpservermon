# Supported tags and respective `Dockerfile` links

`stable` [*(bpodwinski/docker-phpservermon)*](https://github.com/bpodwinski/docker-phpservermon)

### What is this ?

PHP Server Monitor is a script that checks whether your websites and servers are up and running. It comes with a web based user interface where you can manage your services and websites, and you can manage users for each server with a mobile number and email address. [official website](http://www.phpservermonitor.org/).

### Features

- Based on Alpine
- Latest stable versions
- With nginx and PHP7.1

### Ports

- **80**

### Environment

| Variable | Type | Default value |
| -------- | ---- | ------------- |
| **PHP_TIMEZONE** | *optional* | UTC
| **PHP_MEMORY_LIMIT** | *optional* | 256M
| **MAX_UPLOAD** | *optional* | 128M
| **PSM_DB_PORT** | *optional* | 3306
| **UPDATE_INTERVAL** | *optional* | 30

### Volumes

No volume required!