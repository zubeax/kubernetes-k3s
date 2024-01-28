#!/bin/bash

echo "Initial ArgoCD admin password : "
echo $(kubectl -n argocd get secret argocd-initial-admin-secret -o json | jq -r '.data.password' | base64 -d)

exit 0

