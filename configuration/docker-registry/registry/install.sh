#!/bin/bash

##
# CAVEAT: this script installs the TLS-secured version of the registry.
#         it expects a tls chain-of-trust in
#              /usr/local/share/ca-certificates
#         on the master node.
#
#         execute this script on the master node, not with a remote kubectl !
##

dir=$(dirname ${0})
ns='docker-registry'

kubectl create namespace $ns

$dir/tls/create-tls-secret.sh 

kubectl -n $ns apply -f $dir/docker-registry-pv.yaml

echo "Sleeping for 0.5 minutes to let pvc provisioning complete ..."
sleep 30
echo "Continuing"

kubectl -n $ns create configmap docker-registry-config --from-file=config.yml=$dir/docker-registry-config.yaml

kubectl -n $ns apply -f $dir/tls/docker-registry-tls.yaml
kubectl -n $ns apply -f $dir/docker-registry-loadbalancer.yaml

exit 0
