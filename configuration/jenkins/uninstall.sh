#!/bin/bash

NS=jenkins
dot='.'
dryrun='--dry-run'

[[ x${1} == xrun ]] && { dryrun=''; }

pushd . 2>&1 > /dev/null

cd ./helm/jenkins

helm $dryrun --namespace $NS delete jenkins

popd 2>&1 > /dev/null

exit 0

