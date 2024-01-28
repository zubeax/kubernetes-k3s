#!/bin/bash

keyfile='./jfrog_keys.env'
NS=artifactory
dot='.'
dryrun='--dry-run'

[[ ! -f ${keyfile} ]] && { "keyfile $keyfile not found. create it first."; exit -4; }
[[ x${1} == xrun ]] && { dryrun=''; }

. ${keyfile}

pushd . 2>&1 > /dev/null

cd ./helm/artifactory-oss

helm install artifactory $dryrun --namespace $NS --create-namespace \
             --set distribution.joinKeySecretName=joinkey-secret  \
             --set distribution.masterKeySecretName=masterkey-secret \
             --set distribution.jfrogUrl=jfrog.k3s.kippel.de \
             -f ./values.yaml $dot 
              

popd 2>&1 > /dev/null

exit 0

