#!/bin/bash

NS=jenkins
dot='.'
dryrun='--dry-run'

[[ x${1} == xrun ]] && { dryrun=''; }

pushd . 2>&1 > /dev/null

cd ./helm/jenkins

helm install jenkins $dryrun --namespace $NS --create-namespace -f ./values.yaml $dot 
              
popd 2>&1 > /dev/null

./dump-admin-account.sh

exit 0

