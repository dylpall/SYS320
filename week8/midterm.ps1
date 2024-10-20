function getIOC {
$url = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.6/IOC.html

# get tr elements
$trs = $url.parsedhtml.body.GetElementsbytagname("tr")

# empty array
$iocTable = @()

for($i-1; $i -lt $trs.length; $i++) {
    # get td element of tr elements
    $td = $trs[$i].getElementsbytagname("td")
    $iocTable += [pscustomobject]@{
                                "Pattern" = $td[0].innertext;
                                "Explanation" = $td[1].innertext;
                                }
    }
return $iocTable
}
# getIOC

function GetApachelogs {
    $logs = Get-Content C:\Users\champuser\SYS320\week8\access.log
    $logTable = @()

    for($i = 0; $i -lt $logs.Length; $i++) {
        $SplitLogs = $logs[$i] -split " "
        $logTable += [PSCustomObject]@{
                                       "IP" = $SplitLogs[0];
                                       "Time" = $SplitLogs[3].Trim('[');
                                       "Method" = $SplitLogs[5].Trim('"');
                                       "Page" = $SplitLogs[6];
                                       "Protocol" = $SplitLogs[7];
                                       "Response" = $SplitLogs[8];
                                       "Referrer" = $SplitLogs[10];
                                       }
    }
    return $logTable
}
# GetApachelogs | Format-Table

function getIOCLogs(){
    $logTable = GetApachelogs
    $IOCTable = getIOC

    $IOCLogTable = @()
    for($i = 0; $i -lt $logTable.Count; $i++){
        for($j = 0; $j -lt $IOCTable.Count; $j++){
            if ($logTable[$i].Page -match $IOCTable[$j].Pattern){
                $IOCLogTable += $logTable[$i]
            }
        }
    }
return $IOCLogTable

}

 getIOCLogs | Format-Table