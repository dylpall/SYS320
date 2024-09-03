clear

$pathway = Get-Process | Where-Object { ( $_.Path -inotlike "system32")}
$all = $pathway | Select-Object Path
$all | Out-String
