ARG BASE_PHP_IMAGE

FROM ${BASE_PHP_IMAGE} as build-code

COPY pimcore /var/www/pimcore/

WORKDIR /var/www/pimcore

RUN composer install \
    --prefer-dist \
    --no-progress \
    --no-suggest \
    --no-interaction \
    --no-scripts

RUN composer dump-autoload

RUN rm -rf \
    .gitlab \
    dev \
    var/cache \
    var/logs

RUN touch .env

RUN usermod -u 1000 www-data

COPY --from=build-code --chown=www-data /var/www/pimcore /var/www/pimcore

USER www-data

WORKDIR /var/www/pimcore
