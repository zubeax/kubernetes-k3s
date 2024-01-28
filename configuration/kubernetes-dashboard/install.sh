#!/bin/bash

GITHUB_URL=https://github.com/kubernetes/dashboard/releases
VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')

##
# don't install 3.0.0-alpha
##
VERSION_KUBE_DASHBOARD=v2.7.0

echo -e "\n===\nKubernetes Dashboard Version : ${VERSION_KUBE_DASHBOARD}\n===\n"
k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml

dir=$(dirname ${0})
kubectl -n kubernetes-dashboard apply -f $dir/kubernetes-dashboard-loadbalancer.yaml
kubectl -n kubernetes-dashboard apply -f $dir/dashboard.admin-user-role.yml
kubectl -n kubernetes-dashboard apply -f $dir/dashboard.admin-user.yml

exit 0

