FROM registry.k3s.kippel.de:5000/registry:2

LABEL maintainer="axel.zuber@kippel.de"

USER root

COPY ./docker-registry-config.yaml /etc/docker/registry/config.yml

# the registry apparently has to run as root
#USER 1000480000
