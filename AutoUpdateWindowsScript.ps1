Import-Module PSWindowsUpdate

$date=get-date -format "dd-MMM-yyyy"
Get-WUInstall –WindowsUpdate –AcceptAll –AutoReboot -Verbose >> C:\WindowsUpdateLogs\$($date)_$($env:computername)_log.txt


