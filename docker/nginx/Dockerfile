ARG ASSET_IMAGE
FROM ${ASSET_IMAGE} AS assets

FROM nginx:1.21.1-alpine

COPY --from=assets /var/www/pimcore/public /var/www/pimcore/public

WORKDIR /var/www/pimcore/public
