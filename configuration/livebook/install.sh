#!/bin/bash

NAMESPACE=livebook
kubectl create namespace $NAMESPACE
kubectl -n $NAMESPACE apply -f kubectl/pvc.yaml
sleep 60
kubectl -n $NAMESPACE apply -f kubectl/deployment.yaml
kubectl -n $NAMESPACE apply -f kubectl/service.yaml
kubectl -n $NAMESPACE apply -f kubectl/livebook-loadbalancer.yaml
kubectl -n $NAMESPACE apply -f kubectl/ingress.yaml
kubectl -n $NAMESPACE apply -f kubectl/password-secret.yaml

exit 0

