ARG PHP_VERSION=8.3
FROM php:${PHP_VERSION}-cli-alpine

ARG SWOOLE_VERSION
ARG REDIS_VERSION=6.3.0

RUN apk add --no-cache libstdc++ libcurl openssl \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS linux-headers openssl-dev curl-dev \
    && docker-php-ext-install -j"$(nproc)" pcntl pdo_mysql sockets \
    && mkdir -p /usr/src/swoole \
    && curl -fsSL "https://github.com/swoole/swoole-src/archive/refs/tags/v${SWOOLE_VERSION}.tar.gz" \
        | tar xz -C /usr/src/swoole --strip-components=1 \
    && cd /usr/src/swoole \
    && phpize \
    && ./configure --enable-openssl --enable-sockets --enable-mysqlnd --enable-swoole-curl \
    && make -j"$(nproc)" && make install \
    && cd / && rm -rf /usr/src/swoole \
    && pecl install "redis-${REDIS_VERSION}" \
    && docker-php-ext-enable swoole redis \
    && rm -rf /tmp/pear \
    && apk del .build-deps \
    && php --ri swoole > /dev/null

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
