#!/bin/bash

kubectl -n jenkins delete secret/mvn-settings
kubectl -n jenkins create secret generic mvn-settings --from-file=settings.xml=/home/axel/.m2/settings.xml

exit 0
