#!/bin/bash

##
#	Install Master
##
ssh -T rbpic0n1 << EOT
curl -sfL https://get.k3s.io | sh -s - \
		--write-kubeconfig-mode 644 \
		--disable servicelb \
		--token k3sadmin \
		--bind-address 192.168.100.242 \
		--disable-cloud-controller \
		--disable local-storage
EOT

##
#	Install Cluster Nodes
##
export TOKEN=$(ssh rbpic0n1 'cat /var/lib/rancher/k3s/server/node-token')


[[ x$TOKEN == x ]] && { echo "node token is empty. Check master node."; exit -16; }

tee -a /tmp/bufferedstdin << EOT
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.100.242:6443 K3S_TOKEN=$TOKEN sh -
EOT

echo === install command ===
cat /tmp/bufferedstdin

for i in 2 3 4
do
    ssh -T rbpic0n$i < /tmp/bufferedstdin
done

rm -f /tmp/bufferedstdin

# Verify installation
ssh rbpic0n1 'kubectl get nodes'

##
#	Install MetalLB Load Balancer
##
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/metallb/install-metallb.sh'

##
#	Install Longhorn Storage Manager
#	CAVEAT: have to cnfigure SSD nodes post-install,
#           so we pause after the longhorn installation.
#                
#           pause should be about 10 minutes.
##
ssh -T rbpic0n1 '/mnt/shared/vbshared/kubernetes/k3s/configuration/longhorn-system/install-longhorn.sh'

exit 0
