#!/bin/bash

echo "this file is obsolete. install with 'install-local.sh' from the local helm chart" && exit +1

keyfile='./jfrog_keys.env'
NS=artifactory

[[ ! -f ${keyfile} ]] && { "keyfile $keyfile not found. create it first."; exit -4; }

. ${keyfile}

helm upgrade --install distribution --namespace $NS \
             --set distribution.joinKeySecretName=joinkey-secret  \
             --set distribution.masterKeySecretName=masterkey-secret \
             --set distribution.jfrogUrl=artifactory.k3s.kippel.de \
             jfrog/distribution
exit 0

