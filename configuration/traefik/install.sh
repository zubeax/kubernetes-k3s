#!/bin/bash

dir=$(dirname ${0})

kubectl -n kube-system apply -f $dir/traefik-custom-conf.yaml

exit 0

