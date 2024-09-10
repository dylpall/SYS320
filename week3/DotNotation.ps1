. (Join-Path $PSScriptRoot StartAndShutDownTimes.ps1)
. (Join-Path $PSScriptRoot FunctionsandEventLogs.ps1)

clear

# Get login and logoffs from the last 15 days
$loginoutsTable = getTheLogs 15
$loginoutsTable


# get startup table and shutdown from past 25 days
$startuptable = startupandshutdown 25
$startuptable