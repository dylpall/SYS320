clear
function startupandshutdown($daysago){
$startups = Get-EventLog -LogName System -Source EventLog -After (Get-Date).AddDays("-"+"$daysago") | Where-Object {$_.EventID -match "600[5-6]"}

$startuptable = @()

for($i=0; $i -lt $startups.Count; $i++) 
{
    # Creating event
    $event = ""
    if($startups[$i].InstanceID -eq 6005) {$event="Startup"}
    if($startups[$i].InstanceID -eq 6006) {$event="Shutdown"}

    # Creating user
    $user = "system"

    # Adding each new line (in form of a custom object) to our empty array
    $startuptable += [pscustomobject]@{
    "Time" = $startups[$i].TimeGenerated;
    "Id" = $startups[$i].InstanceID;
    "Event" = $event;
    "User" = $user;
}

} # End of for loop

return $startuptable
}
startupandshutdown(365)