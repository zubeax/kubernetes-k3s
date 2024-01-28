#!/bin/bash

keyfile='./jfrog_keys.env'
NS=artifactory

[[ -f ${keyfile} ]] && { echo "keyfile $keyfile already exists. delete if you really want to rerun."; exit 1; }

# Create a master key
MASTER_KEY=$(openssl rand -hex 32)
echo export MASTER_KEY=${MASTER_KEY}       > ${keyfile}

# Create a join key
JOIN_KEY=$(openssl rand -hex 32)
echo export JOIN_KEY=${JOIN_KEY}          >> ${keyfile}

kubectl -n $NS delete secret masterkey-secret
kubectl -n $NS delete secret joinkey-secret
kubectl -n $NS create secret generic masterkey-secret --from-literal=master-key=${MASTER_KEY}
kubectl -n $NS create secret generic joinkey-secret --from-literal=join-key=${JOIN_KEY}

echo export POSTGRES_USERNAME=artifactory >> ${keyfile}  
echo export POSTGRES_PASSWORD=password    >> ${keyfile}  

exit 0

