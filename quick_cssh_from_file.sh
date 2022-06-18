#!/bin/sh

filename=$1

ch="cssh"

usage() {
	echo "Usage: ${0} hosts_file"
}

[[ -z "${filename}" ]] && usage()

while read line; do
	ch+=" ${line}"
done < $filename

