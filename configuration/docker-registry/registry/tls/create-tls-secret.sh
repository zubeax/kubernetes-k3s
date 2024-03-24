#!/bin/bash
# --------------------------------------------------------------------- #
# create-tls-secret.sh                                                  #
#                                                                       #
# create tls secret and ca config map for our private docker registry   #
#                                                                       #
# --------------------------------------------------------------------- #

ns=docker-registry
cacrtname=ca.crt 

##
#  modify the config map file name if this for Kaniko (in the jenkins namespace)
##
[[ x$1 == xjenkins ]] && { ns=jenkins; cacrtname='ca-certificates.crt'; echo "namespace changed to $1"; }

REGISTRY_HOSTNAME=registry.k3s.kippel.de
TLSBASE=/usr/local/share/ca-certificates

TLSCA=$TLSBASE/ca-cert.crt
TLSCERT=$TLSBASE/$REGISTRY_HOSTNAME-cert.crt  
TLSKEY=$TLSBASE/$REGISTRY_HOSTNAME-nopass.key
TLSBUNDLE=$TLSBASE/$REGISTRY_HOSTNAME-bundle.crt

[[ ! -f $TLSCERT   ]] && { echo "$TLSCERT   not found"; exit -4; }
[[ ! -f $TLSKEY    ]] && { echo "$TLSKEY    not found"; exit -4; }
[[ ! -f $TLSCA     ]] && { echo "$TLSCA     not found"; exit -4; }
[[ ! -f $TLSBUNDLE ]] && { echo "$TLSBUNDLE not found"; exit -4; }

kubectl -n $ns delete secret     docker-registry-tls-cert 
kubectl -n $ns delete configmap  docker-registry-tls-ca   
                          
kubectl -n $ns create secret tls docker-registry-tls-cert --cert=$TLSBUNDLE --key=$TLSKEY 
kubectl -n $ns create configmap  docker-registry-tls-ca   --from-file=${cacrtname}=$TLSCA

exit 0

