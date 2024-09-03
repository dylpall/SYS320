$chromeProcess = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($chromeProcess) {
Write-Output "google chrome is already running, stopping all instances."
Stop-Process -Name "chrome" -Force

} else
{
Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" "http://www.champlain.edu"
}