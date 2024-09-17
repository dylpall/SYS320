# Use dot notation to import the function from ApacheLogs.ps1
. ./ApacheLogs.ps1


$results = Retrieve-ApacheLogEntries -Page "index.html" -HttpCode "200" -Browser "Chrome"


$results | Format-Table -AutoSize
