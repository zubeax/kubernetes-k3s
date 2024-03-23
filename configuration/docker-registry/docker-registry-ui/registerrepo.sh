#!/bin/bash
# ------------------------------------------- #
# registerrepo.sh                             #
#                                             #
# register the helm repo for registry-ui      #
# ------------------------------------------- #

helm repo add joxit https://helm.joxit.dev
helm repo update
helm search repo joxit/docker-registry-ui

[[ x$1 == xfetchrepolocal ]] && { helm fetch joxit/docker-registry-ui --untar=true --untardir=./helm; echo "fetched helm repo to ./helm"; exit 0; }

exit 0
