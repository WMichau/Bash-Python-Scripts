#!/bin/bash


CONTROLLER=""
SERIAL=$1

check_controller () {

	#Megacli
	if [ $(sudo -S /opt/MegaRAID/MegaCli/MegaCli64 -adpcount | grep -i controller | awk '{printf $3}' | sed 's/.$//') != "0" ]
	then
		CONTROLLER="MegaCli64"
		return 0
	fi

	#HP
	if sudo -S hpssacli ctrl slot=1 pd all show detail
	then
		CONTROLLER="HP"
		return 0
	fi

	$SAS
	if sudo -S /usr/local/bin/sas2ircu 0 DISPLAY &>/dev/null
	then
		CONTROLLER="SAS"
		return 0
	fi

	echo "No hardware RAID controller"

}

check_controller
echo $CONTROLLER

#MegaCli64 () {
#
#	/opt/MegaRAID/MegaCli/MegaCli64 -PDLIst -aall;
#
#}
#
#HPSsaCli () {
#	
#	hpssacli ctrl slot=1 pd all show detail;
#
#}
#
#SaS () {
#
#	/usr/local/bin/sas2ircu 0 display
#
#}
