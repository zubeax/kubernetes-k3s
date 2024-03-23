#!/bin/bash

wget https://github.com/argoproj/argo-cd/releases/download/v2.9.6/argocd-linux-amd64
wget https://github.com/argoproj/argo-cd/releases/download/v2.9.6/argocd-linux-arm64

scp ./argocd-linux-arm64 rbpic0n1:/usr/local/bin/
ssh rbpic0n1 chmod ugo+x /usr/local/bin/argocd-linux-arm64

sudo mv argocd-linux-amd64 /usr/local/bin/argocd-linux-arm64
sudo chmod ugo+x /usr/local/bin/argocd-linux-arm64

exit 0

