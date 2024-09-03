# Get Ipv4 address from ethternet0 interface
(Get-NetIPAddress -AddressFamily IPv4 | where InterfaceAlias -ilike "Ethernet*").IPAddress

# get ipv4 prefixlength from ethernet interface
(Get-NetIPAddress -AddressFamily IPv4 | where InterfaceAlias -ilike "Ethernet*").PrefixLength

# show classes there are of win32 library that starts with net, sorted alphabetically
Get-WmiObject -list | where { $_.Name -ilike "Win32_Net*" } | Sort-Object

# get dhcp server ip, hide the table headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select DHCPServer | Format-Table -HideTableHeaders

# Get DNS Server IPs for Ethernet and only display 1st one
(Get-DnsClientServerAddress -AddressFamily IPv4 | where InterfaceAlias -ilike "Ethernet*").ServerAddresses[0]

#choose a directory
cd "C:\Users\champuser\Desktop"

# list based on file name
$file=(Get-ChildItem)
for ($s=0; $s -le $file.Length; $s++)
{
    if($file[$s].Extension -ilike "*ps1")
    {
        $file[$s].BaseName + $file[$s].Extension
    }
}

# create a folder if you don't already have one
$folderPath = "C:\Users\champuser\Desktop\"
$filePath = Join-Path $folderPath "out.csv"

# list all the files and save them to csv file
$file | where { $_.Extension -like ".ps1" } | Export-Csv -Path $filePath

# Find every .csv file without changing directory
$file = (Get-ChildItem -Recurse -File)
$file | Rename-Item -NewName { $_.Name -replace '.csv' , '.log' }
Get-ChildItem -Recurse -File