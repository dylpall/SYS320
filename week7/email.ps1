clear

function SendAlertEmail($Body){

$From = "dylan.pallatroni@mymail.champlain.edu"
$To = "dylan.pallatroni@mymail.champlain.edu"
$Subject = "Suspicious Activity"

$Password = "jlki lrpv kkep djuq" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-Port 587 -UseSsl -Credential $Credential

}
sendAlertEmail "Body of email"