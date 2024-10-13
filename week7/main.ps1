. "C:\Users\champuser\SYS320\week6\Event-Logs.ps1"
. "C:\Users\champuser\SYS320\week7\email.ps1"
. "C:\Users\champuser\SYS320\week7\Configuration.ps1"
. "C:\Users\champuser\SYS320\week7\Scheduler.ps1"

# Obtaining configuration
$configuration = readConfiguration

# Obtaining at risk users
$Failed = getFailedLogins $configuration.Days

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($configuration.ExecutionTime)