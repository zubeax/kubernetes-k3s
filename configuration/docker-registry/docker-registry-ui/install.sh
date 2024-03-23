#!/bin/bash

verb="install"
cns=--create-namespace
dryrun=''
valuefile='-f ./helm/values.yaml'
templates='./helm'

NS=docker-registry-ui

    while [[ "${1}" =~ ^-.* ]]
    do
        case "${1}" in
            --help|-h)
                echo "usage: $(basename ${0}) [--upgrade] [--delete] [--dry-run] [-h]"
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

    helm $verb docker-registry-ui --namespace $NS $cns $dryrun $valuefile $templates

exit 0

