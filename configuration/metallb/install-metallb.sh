#!/bin/bash

helm --namespace metallb-system install --create-namespace metallb metallb/metallb 

##
# the installation creates 2 custom resource definitions (CRDs) :
# - ipaddresspool.metallb.io/default-pool
# - l2advertisement.metallb.io/l2-ip
##

echo "Wait for 60 s to ensure the metallb webhook is available ..."
sleep 60
echo "Create metallb custom resource definitions"

dir=$(dirname ${0})
kubectl -n metallb-system apply -f $dir/values-cr.yaml

exit 0

