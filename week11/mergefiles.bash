#!/bin/bash

logdir="/var/log/apache2/"

alllogs=$(ls "${logdir}" | grep "access.log" | grep -v "other_vhosts" | grep -v "gz")

:> access.txt

for i in ${alllogs}
do
	cat "${logdir}${i}" >> access.txt
done

tail access.txt
