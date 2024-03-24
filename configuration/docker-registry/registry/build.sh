#!/bin/bash

#REGISTRY=registry.k3s.kippel.de:5000
REGISTRY=192.168.100.157:5000
IMAGE=/kubernetes/docker/registry
TAG=2.1

cache=''
[[ x$1 == x-no ]] && { cache='--no-cache'; }

docker build --progress=plain $cache -t ${REGISTRY}${IMAGE}:${TAG} . 
docker push ${REGISTRY}${IMAGE}:${TAG} 

exit 0

