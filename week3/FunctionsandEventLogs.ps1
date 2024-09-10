# get event login and logoff records
#Get-EventLog -LogName System -Source Microsoft-Windows-WinLogon

# Get login and logoff events and save as a variable
# Get the last 14 days
$loginouts = Get-EventLog System -Source Microsoft-Windows-WinLogon -After (Get-Date).AddDays("-"+"14")

$loginouts = @()
for($i=0; $i -lt $loginouts.Count; $i++){

    # Creating event property value
    $event = ""
    if($loginouts[$i].InstanceID -eq 7001) {$event="logon"}
    if($loginouts[$i].InstanceID -eq 7002) {$event="logoff"}

    # Creating user property value
    $user = $loginouts[$i].ReplacementStrings[1]

    # Adding each new line (in form of a custom object) to our empty array
    $loginoutsTable += [loginouts]@{"Time" = $loginouts[$i].TimeGenerated(); `
                                    "Id" = $loginouts[$i].InstanceID; `
                                    "Event" = $event; `
                                    "User" = $user;
                                    }
} # End of for loop

$loginoutsTable