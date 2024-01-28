#!/bin/bash

[[ ! -f /var/lib/rancher/k3s/server/manifests/local-storage.yaml ]] && { echo "local-storage.yaml not found."; exit 1; }

sudo cp /var/lib/rancher/k3s/server/manifests/local-storage.yaml /var/lib/rancher/k3s/server/manifests/custom-local-storage.yaml

sudo sed -i -e "s/storageclass.kubernetes.io\/is-default-class: \"true\"/storageclass.kubernetes.io\/is-default-class: \"false\"/g" /var/lib/rancher/k3s/server/manifests/custom-local-storage.yaml

exit 0

