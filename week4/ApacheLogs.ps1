clear


# List all of the apache logs of xampp
#Get-Content C:\xampp\apache\logs\access.log

# List only last 5 apache logs
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

# Display only logs that contain 404 (Not found) or 400 (bad request)
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

# Display only logs that does NOT contain 200 (ok)
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

# From every .log file in the directory, only get the logs that contains the word 'error'
#$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
# Display last 5 elements of the result array
#$A | select -Last 5

<#
# Get only logs that contain 404, save into $notfounds
$notfounds = Get-ChildItem C:\xampp\apache\logs\access.log | Select-String ' 404 '

# Define a regex for IP addresses
$regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

# Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Matches($notfounds)

# Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].value; }
}
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group ip
$counts | Select-Object Count, Name
#>

function getApacheLogs($page,$statuscode,$browser){
 $snag = Get-Content C:\xampp\apache\logs\access.log
 $matchall = $snag | Select-String "$page" | Select-String $statuscode | Select-String $browser

 $regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
 $ipsUnorganized = $regex.Matches($matchall)

 $accessTable = @()
 for($i=0; $i -lt $matchall.count; $i++){
  $accessTable += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].value; `
                                     "Page" = $page; `
                                     "Status Code" = $statuscode; `
                                     "Browser" = $browser; `
                                     }
 }

 return $accessTable
}

getApacheLogs "index.html" " 200 " "Chrome"