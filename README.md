# Pimcore Helm Chart

> Helm chart example for pimcore

**Table of Contents**

- [Pimcore Helm Chart](#pimcore-helm-chart)
	- [Requirements](#requirements)
	- [Docker](#docker)
	- [Helm](#helm)
	- [Useful Commands](#useful-commands)
	- [Troubleshooting](#troubleshooting)

## Requirements

- [Docker/Kubernetes](https://www.docker.com/)
- [Helm](https://helm.sh/)
- [Helmsman](https://github.com/Praqma/helmsman)
- [Minikube](https://minikube.sigs.k8s.io/)

## Docker

Build the docker image

```bash
docker build . -t <username>/<repository_php_base> -f ./docker/php-base/Dockerfile
docker build . -t <username>/<repository_php> -f ./docker/php/Dockerfile --build-arg BASE_PHP_IMAGE=<username>/<repository_php_base>
docker build . -t <username>/<repository_nginx> -f ./docker/nginx/Dockerfile --build-arg ASSET_IMAGE=<username>/<repository_php>
```

Push the docker image

```bash
docker push <username>/<repository_php_base>
docker push <username>/<repository_php>
docker push <username>/<repository_nginx>
```

## Helm

Start minikube

```bash
minikube start --vm=true --driver=hyperkit
minikube addons enable ingress
```

Note your minikube IP and set to your hosts

```bash
minikube ip

sudo vim /etc/hosts
# YOUR_MINIKUBE_IP bosch-myixo.com
```

Apply all charts

``` bash
helmsman -apply -f helm/helm.yaml -debug -verbose
```

## Useful Commands

```bash
kubectl exec -i -t PHP_POD --namespace=pimcore -- /bin/sh
```

## Troubleshooting

If `helm-diff` plugin is missing, run this command:

```bash
helm plugin install https://github.com/databus23/helm-diff
```
