#!/bin/bash

datetime=$(systemctl status certmonger.service | grep Active | awk '{ print $6}')
timeago='30 days ago'

dtSec=$(date --date "$datetime" +'%s')
taSec=$(date --date "$timeago" +'%s')

echo -n "Service uptime: " 
systemctl status certmonger.service | grep Active | awk '{n = 3; for (--n; n >= 0; n--){ printf "%s'\ '",$(NF-n)} print ""}'


if [[ $dtSec -lt $taSec ]]
then
	echo "Service restart"
	#systemctl restart certmonger.service
fi
while read -r line
do
	if [[ $line == "MONITORING" ]]
	then
		echo "OK"
	elif [[ $line == "NEED_CSR" ]]
	then
		sudo -S ipa-getcert list | grep -i NEED_CSR -A 3 -B 1
	fi
done <<<$(sudo -S ipa-getcert list | grep -i status | awk '{print $NF}')


