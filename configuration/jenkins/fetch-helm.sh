#!/bin/bash

echo "remove this statement so you can re-fetch" && exit -4;

helm fetch jenkinsci/jenkins  --untar=true --untardir=.

exit 0


