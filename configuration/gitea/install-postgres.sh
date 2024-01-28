#!/bin/bash

kubectl create namespace gitea

dir=$(dirname ${0})
kubectl -n gitea apply -f $dir/postgres-secret.yaml
kubectl -n gitea apply -f $dir/postgres-configmap.yaml
kubectl -n gitea apply -f $dir/postgres-statefulset.yaml
kubectl -n gitea apply -f $dir/postgres-service.yaml

exit 0

