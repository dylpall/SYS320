#! /bin/bash

accesslog="$1"
ioc="$2"

cat "$accesslog" | egrep -i -f "$ioc" | cut -d' ' -f1,4,7 | tr -d '[' > report.txt
