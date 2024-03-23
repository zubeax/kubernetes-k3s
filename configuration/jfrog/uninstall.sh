#!/bin/bash

NS=artifactory
dot='.'
dryrun='--dry-run'

[[ x${1} == xrun ]] && { dryrun=''; }

pushd . 2>&1 > /dev/null

cd ./helm/artifactory

helm delete artifactory --namespace $NS

popd 2>&1 > /dev/null

exit 0

