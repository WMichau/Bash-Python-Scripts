#!/bin/bash
hosts_f=$1
pass_f=$2

readarray -t arr < $pass_f

while read -r line; do
	ssh -n ${line} "sudo su -c 'find /tmp/ -type f -iname '*zutylizuj*' -delete'"
done < $hosts_f


#issue_to_resolve
#ssh repo-1.dc-2.tools.dcwp.pl "sudo su -c 'cd ~/operator/systemy/; echo "" >> ./repo.txt; printf "%s\n" "${arr[@]}" >> ./repo.txt'"
