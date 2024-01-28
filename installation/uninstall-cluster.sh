#!/bin/bash

for i in 2 3 4
do
	ssh rbpic0n$i '/usr/local/bin/k3s-agent-uninstall.sh'
done

ssh rbpic0n1 '/usr/local/bin/k3s-uninstall.sh'


for i in 1 2 3 4
do
	ssh rbpic0n$i 'rm -rf /mnt/sda3/*'
done

exit 0

