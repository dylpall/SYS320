#! /bin/bash

date=$(date '+%Y-%m-%d %H-%M-%S')
echo "File was accessed $date" >> fileaccesslog.txt

echo "To: dylan.pallatroni@mymail.champlain.edu" > emailform2.txt
echo "Subject: File accessed!" >> emailform2.txt
cat fileaccesslog.txt >> emailform2.txt
cat emailform2.txt | ssmtp dylan.pallatroni@mymail.champlain.edu
