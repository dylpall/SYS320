#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
	logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
	dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
	echo "$dateAndUser"
}

function getFailedLogins(){

	fuser=$(cat "$authfile" | grep "lightdm" | grep "fail")
	echo "$fuser"

}

echo "To: dylan.pallatroni@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
getFailedLogins >> emailform.txt
cat emailform.txt | ssmtp dylan.pallatroni@mymail.champlain.edu


