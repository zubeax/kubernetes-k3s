#!/bin/bash
# --------------------------------------------------- #
#  distribute certificates generated with our private #
#  root/server chain to all cluster nodes.            #
#                                                     #
#  distribute /etc/rancher/k3s/registries.yaml        #
#  to all cluster nodes                               #
# --------------------------------------------------- #

export REGISTRY_HOSTNAME=registry.k3s.kippel.de

export TLSBASE=../../pki/service-certificates
export DESTBASE=/usr/local/share/ca-certificates

export TLSCA=$TLSBASE/ca-cert.crt
export TLSCERT=$TLSBASE/$REGISTRY_HOSTNAME-cert.crt
export TLSKEY=$TLSBASE/$REGISTRY_HOSTNAME-nopass.key
export TLSBUNDLE=$TLSBASE/$REGISTRY_HOSTNAME-bundle.crt

[[ ! -f $TLSCERT   ]] && { echo "$TLSCERT   not found"; exit -4; }
[[ ! -f $TLSKEY    ]] && { echo "$TLSKEY    not found"; exit -4; }
[[ ! -f $TLSCA     ]] && { echo "$TLSCA     not found"; exit -4; }
[[ ! -f $TLSBUNDLE ]] && { echo "$TLSBUNDLE not found"; exit -4; }

tee /tmp/registries.yaml > /dev/null << EOT
mirrors:
  docker.io:
    endpoint:
      - "https://$REGISTRY_HOSTNAME:5000"
  "$REGISTRY_HOSTNAME":
    endpoint:
      - "https://$REGISTRY_HOSTNAME:5000"
configs:
  $REGISTRY_HOSTNAME:5000:
    tls:
      cert_file: $DESTBASE/$REGISTRY_HOSTNAME-bundle.crt
      key_file: $DESTBASE/$REGISTRY_HOSTNAME-nopass.key
      ca_file: $DESTBASE/ca-cert.crt
EOT

for i in 1 2 3 4
do
    scp ../../pki/service-certificates/${REGISTRY_HOSTNAME}-nopass.key ../../pki/service-certificates/${REGISTRY_HOSTNAME}*.crt ../../pki/service-certificates/ca-cert.crt rbpic0n$i:/usr/local/share/ca-certificates
    ssh rbpic0n$i 'mkdir -p /etc/rancher/k3s'
    scp /tmp/registries.yaml rbpic0n$i:/etc/rancher/k3s/registries.yaml
done

rm -f /tmp/registries.yaml

exit 0

