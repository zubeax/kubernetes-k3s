#!/bin/bash

NS=jenkins
objname=regcred

REGISTRY_URL=https://registry.k3s.kippel.de:5000/v2/
REGISTRY_USER=axel
REGISTRY_PASS=registrypass
REGISTRY_EMAIL=axel@kippel.de

kubectl -n $NS delete secret    $objname
kubectl -n $NS delete configmap $objname

kubectl -n $NS create secret \
    docker-registry $objname \
    --docker-server=$REGISTRY_URL \
    --docker-username=$REGISTRY_USER \
    --docker-password=$REGISTRY_PASS \
    --docker-email=$REGISTRY_EMAIL

# jenkins pod templates don't provide the capability
# to mount a key from a secret, so we create a configmap
# from the secret payload.

kubectl -n $NS get secret $objname -o jsonpath='{.data.\.dockerconfigjson}' | base64 -w0 -d | jq '.' > /tmp/regcred.json
kubectl -n $NS create configmap $objname --from-file=config.json=/tmp/regcred.json
rm -f /tmp/regcred.json

exit 0

