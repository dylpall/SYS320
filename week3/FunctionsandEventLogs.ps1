# get event login and logoff records
#Get-EventLog -LogName System -Source Microsoft-Windows-WinLogon

# Get login and logoff events and save as a variable
# Get the last 14 days
$loginouts = Get-EventLog -LogName System -Source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)

$loginouts = @()
for($i=0; $i -lt $loginouts.Count; $i++) 
{

    # Creating event property value
    $event = ""
    if($loginouts[$i].EventID -eq '21') {$event="Logon"}
    if($loginouts[$i].EventID -eq '23') {$event="Logoff"}

    # Creating user property value
    $user = $loginouts[$i].ReplacementStrings[$i]

    # Adding each new line (in form of a custom object) to our empty array
    $loginoutsTable += [loginouts]@{"Time" = $loginouts[$i].ToString()
                                      "Id" = $loginouts[$i].ToString()
                                   "Event" = $event;
                                    "User" = $user;
                                    }
} # End of for loop

$loginoutsTable
