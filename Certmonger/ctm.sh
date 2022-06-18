#!/bin/bash

hosts_f=$1

while read -r line;
do
    ssh $line 'bash -s' < ./test.sh
done < $hosts_f
