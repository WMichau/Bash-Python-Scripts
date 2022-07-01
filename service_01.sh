#!/bin/bash

#Usage: ${0} ServiceName Deisred_State

service=$1
desired_state=$2

[[ -z "${service}" ]] && echo "no service name"
[[ -z "${desired_state}" ]] && echo "no state"

if [[ ! -f /etc/systemd/system/${service}.service ]]; then
        echo "error: no such service";
fi

IFS='='
read dummy state < <(systemctl show ${service} | grep ActiveState)

if [[ "${state}" == "${desired_state}" ]]; then
        echo 1
else
        echo 0
fi
