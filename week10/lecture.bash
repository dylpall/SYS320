#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function pageCount(){
awk '{print $7}' "$file" | sort | uniq -c
}

pageCount
