#!/bin/bash

verb=install
cns=--create-namespace
dryrun=''
valuefile='-f ./values.yaml'
templates='.'

ns=jenkins
svc=jenkins

    while [[ "${1}" =~ ^-.* ]]
    do
        case "${1}" in
            --help|-h)
                echo "usage: $(basename ${0}) [--upgrade] [--delete] [--list] [--dry-run] [-h]"
                exit 1
                shift;;
            --upgrade|-u)
                verb=upgrade
                cns=''
                shift;;
            --delete)
                verb=delete
                cns=''
                valuefile=''
                templates=''
                shift;;
            --list)
                verb=list
                cns=''
                svc=''
                valuefile=''
                templates=''
                shift;;
            --dry-run|--dryrun|-d)
                dryrun='--dry-run'
                shift;;
            *)  shift;;
        esac
    done

    pushd . 2>&1 > /dev/null
    cd ./helm/jenkins

    helm $verb $svc --namespace $ns $cns $dryrun $valuefile $templates

    popd 2>&1 > /dev/null
    ./dump-admin-account.sh

exit 0

