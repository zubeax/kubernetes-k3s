#!/bin/bash

echo "Initial ArgoCD admin password : "
echo $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

exit 0

