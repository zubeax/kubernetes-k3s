#!/bin/bash

dir=$(dirname ${0})
ns='docker-registry'

kubectl -n $ns delete configmap docker-registry-config
kubectl -n $ns create configmap docker-registry-config --from-file=config.yml=$dir/docker-registry-config.yaml
kubectl -n $ns rollout restart deployment.apps/docker-registry

exit 0
