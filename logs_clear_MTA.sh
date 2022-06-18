#!/bin/bash
for dc in {1..2}
do
 for i in {1..12}
 do
 	if [ "$(ssh mta-$i.dc-$dc.poczta.dcwp.pl df -h | grep var | awk '{print $5+0}')" -gt "90" ]
 	then
 		ssh mta-$i.dc-$dc.poczta.dcwp.pl "sudo su -c '>/var/log/antyspam-json.log'"
 
	echo "mta-$i.dc-$dc.poczta.dcwp.pl | $(date '+%d/%m/%Y %H:%M:%S')" >> mta_log.log
 fi
 done
done
