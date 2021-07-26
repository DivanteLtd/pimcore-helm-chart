# Pimcore Helm Chart

> Helm chart example for pimcore

**Table of Contents**

- [Pimcore Helm Chart](#pimcore-helm-chart)
	- [Requirements](#requirements)
	- [Docker](#docker)
	- [Helm](#helm)

## Requirements

- [Docker](https://www.docker.com/)

## Docker

Build the docker image

```bash
docker build . -t <username>/<repository_php_base> -f ./docker/php-base/Dockerfile
docker build . -t <username>/<repository_php> -f ./docker/php/Dockerfile --build-arg BASE_PHP_IMAGE=<username>/<repository_php_base>
docker build . -t <username>/<repository_nginx> -f ./docker/nginx/Dockerfile --build-arg ASSET_IMAGE=<username>/<repository_php>
```

Push the docker image

```
docker push <username>/<repository_php_base>
docker push <username>/<repository_php>
docker push <username>/<repository_nginx>
```

## Helm

...
