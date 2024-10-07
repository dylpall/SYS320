clear

function readConfiguration {
    $getconfig = Get-Content -Path "C:\Users\champuser\SYS320\week7\configuration.txt"
    $data = @()
    for($i = 0; $i -lt 1; $i++){
        $data += [pscustomobject]@{
                                "Days" = $getconfig[0];
                                "ExectuionTime" = $getconfig[1];
        }
    }
    return $data
}


function changeFunction {
    $newDays = Read-Host -Prompt "Enter the number of days for which the logs will be obtained"
    $newTime = Read-Host -Prompt "Enter the daily execution time of the script"
    $newData = $newDays, $newTime
    Set-Content -Path "C:\Users\champuser\SYS320\week7\configuration.txt" -Value $newData
}

function configurationMenu {
    $Prompt = "Please choose your operation:`n"
    $Prompt += "1 - Show Configuration`n"
    $Prompt += "2 - Change Configuration`n"
    $Prompt += "3 - Exit`n"

    $operation = $true
while($operation) {
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 3){
        Write-Host "Goodbye!" | Out-String
        exit
        $operation = $false
    }
    elseif($choice -eq 1) {
        readConfiguration
        
    }
  }
}
configurationMenu