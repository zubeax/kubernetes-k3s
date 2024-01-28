#!/bin/bash

export NS='jenkins'
export secret='jenkins'

function dumpsecret()
{
    value=$(kubectl -n $NS get secret $secret -o jsonpath=${1})
    echo $(echo $value | base64 -w0 -d)
}

printf "%-8s : %s\n" "user"     $(dumpsecret "{.data.jenkins-admin-user}")
printf "%-8s : %s\n" "password" $(dumpsecret "{.data.jenkins-admin-password}")

exit 0

