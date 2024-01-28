#!/bin/bash

kubectl -n metallb-system -o yaml get l2advertisement.metallb.io
kubectl -n metallb-system -o yaml get ipaddresspool.metallb.io/default-pool

exit 0

