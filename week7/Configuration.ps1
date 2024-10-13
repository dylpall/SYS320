clear

function readConfiguration {
    $data = (Get-Content -Path C:\Users\champuser\SYS320\week7\configuration.txt)
    $Days = $data[0]
    $Time = $data[1]
    return [PSCustomObject]@{
        Days = $Days
        ExecutionTime = $Time
      }
}


function changeConfiguration {
    
        $Days = Read-Host "Enter the number of days for which the logs will be obtained"
        if ($Days -match '^\d+$') {
        } else {
            Write-Host "Invalid input."
            continue
        }

        $Time = Read-Host "Enter the daily execution time of the script (e.g., 3:42 PM)"
        if ($Time -match '[1]{0,1}\d:[0-5]\d\s(AM|PM)') {
        } else {
            Write-Host "Invalid input."
            continue
        }
    "$Days`n$Time" | Set-Content C:\Users\champuser\SYS320\week7\configuration.txt   
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
        readConfiguration | Out-String
        
    }
    elseif($choice -eq 2) {
        changeConfiguration | Out-String
    }
  }
}
configurationMenu