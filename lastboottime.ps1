Get-WmiObject -class Win32_OperatingSystem | Select-Object  __SERVER,@{label='LastBootUpTime';expression={$_.ConvertToDateTime($_.LastBootUpTime)}}

Start-Sleep 20