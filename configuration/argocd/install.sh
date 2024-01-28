#!/bin/bash

# patch the image names
sed -i 's,quay.io/argoproj/argocd,alinbalutoiu/argocd,g' install.yaml

# apply it
kubectl apply --namespace argocd -f install.yaml

exit 0

