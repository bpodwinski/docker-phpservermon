FROM php:7.4-fpm-alpine
LABEL maintainer="contact@benoitpodwinski.com"

ENV PHP_TIMEZONE UTC
ENV PHP_MEMORY_LIMIT 512M
ENV MAX_UPLOAD 128M
ENV PSM_DB_PORT 3306
ENV UPDATE_INTERVAL 120
ARG PHPSERVERMON_VER=3.5.2

ADD https://github.com/phpservermon/phpservermon/archive/v${PHPSERVERMON_VER}.zip /tmp/phpservermon.zip

RUN apk add --no-cache --update libxml2-dev curl-dev supervisor nginx curl git \
	&& docker-php-ext-install mysqli pdo_mysql curl xml sockets \
    && mkdir /logs /run/nginx \
	&& rm -rf /var/www/* \
    && cd /tmp \
    && unzip -q phpservermon.zip -d ./ \
    && cp -r phpservermon-${PHPSERVERMON_VER}/* /var/www \
    && rm -rf phpservermon.zip phpservermon \
    && cd /var/www \
    && php composer.phar install \
    && apk del --purge libxml2-dev curl-dev git \
    && sed -i -e "s/user = www-data/user = root/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i -e "s/group = www-data/group = root/g" /usr/local/etc/php-fpm.d/www.conf

COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY update_status.sh /usr/local/bin/update_status.sh
COPY php.ini /usr/local/etc/php/php.ini
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh \
	&& chmod +x /usr/local/bin/update_status.sh

WORKDIR /var/www

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
