$csvPath = "C:\Users\champuser\Desktop\Processes.csv"

$stoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' }

$sortedStoppedServices = $stoppedServices | Select-Object ServiceName, DisplayName | Sort-Object ServiceName

$sortedStoppedServices | Export-Csv -Path $csvPath -NoTypeInformation

Write-Output "Stopped services have been saved to $csvPath"