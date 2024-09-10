function Get-StartupandShutDown {
# Get startup and shutdown events from system

$events = Get-EventLog System -InstanceId 6005