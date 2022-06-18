#!/bin/sh

filename=$1

ch="cssh"

while read line; do
	ch+=" ${line}"
done < $filename

