#!/bin/bash

[[ x"$1" == x ]] && { echo "usage: $(dirname $0) <commit message>"; exit 1; }

git add -A
git commit -m "$1"
git push -u origin main

exit 0

