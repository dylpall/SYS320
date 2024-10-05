Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
. (Join-Path $PSSCriptROot Users.ps1)
. (Join-Path $PSSCriptRoot Event-Logs.ps1)

$Prompt = "Please choose an option:`n"
$Prompt += "1 - Display last 10 Apache Logs`n"
$Prompt += "2 - Display last 10 Failed Logins`n"
$Prompt += "3 - Display at Risk Users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 5){
        Write-Host "Goodbye!" | Out-String
        exit
        $operation = $false
    }
    elseif($choice -eq 1){
        Get-Content C:\xampp\apache\logs\access.log -Tail 10 | Out-String
    }
    elseif($choice -eq 2){
        $userLogins = getFailedLogins $days
        Write-Host ($userLogins | Select -First 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 3){
        $failList = @()
        $userLogins = getFailedLogins $days
        if($userLogins.count -le 0){
            Write-Host "No at risk users in the past $days days" | Out-String
        }
    }

    elseif($choice -eq 4){
        if($running -eq $true){
            try {Stop-Process -Name "chrome"} catch {Write-Host "Chrome Instance Already Closed"}
            $running = $false
    }
    else{
        Start-Process -FilePath "chrome" "https:///www.champlain.edu"
        $running = $true
    }
    Out-String
}
}
