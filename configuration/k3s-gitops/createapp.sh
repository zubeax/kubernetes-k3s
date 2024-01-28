#!/bin/bash

[[ x$1 == x ]] && { echo "usage $(basename $0) <application>"; exit 1; }
[[ ! -d $1  ]] && { echo "no directory $1 found"; exit -4; }

argocd app create $1 --repo http://git.k3s.kippel.de/axel/k3s-gitops.git --path $1 --dest-server https://kubernetes.default.svc --dest-namespace $1

exit 0

