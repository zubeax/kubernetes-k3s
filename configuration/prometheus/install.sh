#!/bin/bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm install prometheus prometheus-community/kube-prometheus-stack --create-namespace -n prometheus

kubectl get pods -n prometheus

dir=$(dirname ${0})

kubectl -n prometheus apply -f $dir/prometheus-loadbalancer.yaml

exit 0

