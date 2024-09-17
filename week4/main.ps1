# Use dot notation to import the function from ApacheLogs.ps1
. ./ApacheLogs.ps1
. ./ParsingApacheLogs.ps1

$tablerecords = .\ParsingApacheLogs.ps1
$tablerecords | Format-Table -AutoSize
$results = Retrieve-ApacheLogEntries -Page "index.html" -HttpCode "200" -Browser "Chrome"


$results | Format-Table -AutoSize