#!/bin/bash
# -------------------------------------------------- #
#  install-baseimages.sh                             #
#                                                    #
#  download a number of base images from docker hub  #
#  and push them to our private registry.            #
# -------------------------------------------------- #

export REGISTRY='registry.k3s.kippel.de:5000'

while read hub bi tag
do
    echo "=== $hub/$bi:$tag"
    docker pull $bi:$tag
    docker tag  $hub/$bi:$tag $REGISTRY/$bi:$tag
    docker push $REGISTRY/$bi:$tag  
    docker rmi  $hub/$bi:$tag  
done<<EOT
docker.io arm64v8/maven amazoncorretto
EOT
# docker.io nginx    latest
# docker.io alpine   latest
# docker.io debian   latest
# docker.io registry 2
# EOT

exit 0

