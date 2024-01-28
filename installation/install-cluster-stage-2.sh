#!/bin/bash

##
#	Activate Traefik Dashboard
##
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/traefik/install.sh'

###
#	Install Kubernetes Dashboard
##
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/kubernetes-dashboard/install.sh'

##
#	Install private docker registry
##
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/docker-registry/install.sh'

#	Install Prometheus
##
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/prometheus/install.sh'

##
#	Install Gitea
#	CAVEAT: have to edit gitea-values.yaml
##
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/gitea/install-postgres.sh'
sleep 600
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/gitea/install-gitea-service.sh'

exit 0

