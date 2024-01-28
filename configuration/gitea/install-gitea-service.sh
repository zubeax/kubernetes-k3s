#!/bin/bash

dir=$(dirname ${0})

helm repo add gitea-charts https://dl.gitea.io/charts/
helm repo update
helm install gitea gitea-charts/gitea --namespace gitea --create-namespace --values $dir/gitea-values.yaml

kubectl -n gitea apply -f $dir/gitea-loadbalancer.yaml

exit 0

