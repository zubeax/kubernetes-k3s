#!/bin/bash

curl -fL https://install-cli.jfrog.io | sh

cat << EOF
If jfrog-cli was successfully installed, connect it to the deploy artifactory-oss instance.

jf config add

unique server identifier : artifactory
JFrog Platform URLi      : http://artifactory.k3s.kippel.de/
authentication methods   : Username and Password / API Key
JFrog username           : admin
JFrog password or API key: <as generated in the Web UI
EOF

exit 0

