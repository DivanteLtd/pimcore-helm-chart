FROM php:8.0.8-fpm-alpine3.14

RUN apk add --update --no-cache \
    graphviz \
    shadow \
    ffmpeg

# todo add all missing packages

COPY --from=harbor-1.divante.pl/proxy/library/composer:2.0.14 /usr/bin/composer /usr/bin/composer

RUN mkdir -p /root/.composer

# COPY . /var/www/pimcore/

# RUN composer install \
#     --prefer-dist \
#     --no-progress \
#     --no-suggest \
#     --no-interaction \
#     --no-scripts

# RUN composer dump-autoload

# RUN rm -rf \
#     .gitlab \
#     dev \
#     var/cache \
#     var/logs

# RUN touch .env

RUN usermod -u 1000 www-data
USER www-data

WORKDIR /var/www/pimcore
