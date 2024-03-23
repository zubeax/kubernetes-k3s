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

if [ x$dryrun != x ]
then
kubectl -n $NS create secret generic masterkey-secret --from-literal=master-key=${MASTER_KEY}
kubectl -n $NS create secret generic joinkey-secret   --from-literal=join-key=${JOIN_KEY}
fi

helm upgrade --install artifactory-oss $dryrun --namespace $NS --create-namespace \
             --set artifactory.joinKeySecretName=joinkey-secret  \
             --set artifactory.masterKeySecretName=masterkey-secret \
             --set artifactory.postgresql.postgresqlPassword=${POSTGRES_PASSWORD} \
             --set artifactory.jfrogUrl=artifactory.k3s.kippel.de \
             -f ./values.yaml $dot 

popd 2>&1 > /dev/null

exit 0

