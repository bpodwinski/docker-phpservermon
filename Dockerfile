FROM php:fpm-alpine
MAINTAINER Benoit Podwinski

ENV PHP_TIMEZONE UTC
ENV PHP_MEMORY_LIMIT 256M
ENV MAX_UPLOAD 128M
ENV PSM_DB_PORT 3306
ENV UPDATE_INTERVAL 30

RUN mkdir /run/nginx

WORKDIR /var/www

RUN apk add --no-cache --update libxml2-dev curl-dev supervisor nginx curl git \
	&& docker-php-ext-install mysqli pdo_mysql curl xml \
	&& rm -rf /var/www/* \
    && git clone https://github.com/phpservermon/phpservermon.git ./ \
    && php composer.phar install \
    && rm -rf Makefile Vagrantfile composer* .git \
    && apk del --purge git libxml2-dev curl-dev

COPY supervisord.conf /etc/
COPY nginx.conf /etc/nginx/
COPY update_status.sh /usr/local/bin/
COPY php.ini /usr/local/etc/php/
COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh \
	&& chmod +x /usr/local/bin/update_status.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80 443
