#!/bin/bash

dir=$(dirname ${0})

kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.5.1/deploy/longhorn.yaml

kubectl -n longhorn-system apply -f $dir/longhorn-loadbalancer.yaml

exit 0

