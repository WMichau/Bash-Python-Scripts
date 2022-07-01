#!/bin/bash

#Usage: ssh IP/NAME "bash -s" < /path/disk_localization.sh SERIALNUMBER

CONTROLLER=""
SERIAL=$1

check_controller () {

	SLOT=$(sudo -S hpssacli ctrl all show config | sed -n 2p | awk '{print $6}')

	if [ $(sudo -S /opt/MegaRAID/MegaCli/MegaCli64 -adpcount | grep -i controller | awk '{printf $3}' | sed 's/.$//') != "0" ]
	then
                CONTROLLER="MegaCli64"

        elif sudo -S hpssacli ctrl slot=$SLOT pd all show detail &>/dev/null
        then
                CONTROLLER="HP"

        elif sudo -S /usr/local/bin/sas2ircu 0 DISPLAY &>/dev/null
        then
                CONTROLLER="SAS"

        else
                echo "No hardware RAID controller"
                exit 0
        fi
}

get_localization () {

        check_controller
        if [ $CONTROLLER == "MegaCli64" ]
        then
                sudo -S /opt/MegaRAID/MegaCli/MegaCli64 -PDLIst -aall | grep -i "Enclosure Device\|Slot\|Device id\|Drive's position\|$SERIAL" | grep "$SERIAL"  -B 4
        elif [ $CONTROLLER == "HP" ]
        then
                sudo -S hpssacli ctrl slot=$SLOT pd all show detail | grep -i "Port\|Box\|Bay\|Model\|$SERIAL" | grep "$SERIAL" -B 3 -A 1
        elif [ $CONTROLLER == "SAS" ]
        then
                sudo -S /usr/local/bin/sas2ircu 0 DISPLAY | grep -i "Enclosure\|Slot\|State\|Model\|$SERIAL" | grep "$SERIAL" -B 4
        fi
}

get_localization
