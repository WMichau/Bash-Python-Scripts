#!/bin/bash
hosts_f=$1
pass_f=$2

readarray -t arr < $pass_f

while read -r line; do
	ssh -n ${line} "sudo su -c 'find /tmp/ -type f -iname '*zutylizuj*' -delete'"
done < $hosts_f

scp $pass_f repo-1.dc-2.tools.dcwp.pl:/tmp/

ssh -t -n repo-1.dc-2.tools.dcwp.pl "sudo -i awk 'BEGIN{print""}1' /tmp/$pass_f | sudo -i tee -a /root/operator/systemy/repo.txt"
