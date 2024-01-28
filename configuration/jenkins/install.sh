#!/bin/bash

NAMESPACE=jenkins
kubectl create namespace $NAMESPACE
kubectl -n $NAMESPACE apply -f kubectl/volume.yaml
sleep 60
kubectl -n $NAMESPACE apply -f kubectl/serviceAccount.yaml
kubectl -n $NAMESPACE apply -f kubectl/deployment.yaml
kubectl -n $NAMESPACE apply -f kubectl/service.yaml
kubectl -n $NAMESPACE apply -f kubectl/jenkins-loadbalancer.yaml

exit 0

