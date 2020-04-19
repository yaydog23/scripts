  #e mail parameters
   
$From = ""
$To = ""
$SMTPServer = ""   
$SMTPPort = ""
$username = ''
$password = ''
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$Subject = "Monitoring alert from $env:computername"
   
   #disk parameters
   $disk_space_critical_percentage= 0.1
 
$pingstatus= Test-connection -ComputerName google.com -Quiet -Count 2
$ipV4 = (Test-Connection -ComputerName $env:computername -count 1).IPV4Address.ipaddressTOstring
   
        If ($pingstatus -eq $true) 

{


        
        #disk monitoring

    
        $disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace
        
        $disksizeGB=[math]::Round($disk.Size/ 1GB,2)
        $disksizefreeGB=[math]::Round($disk.FreeSpace/ 1GB,2)    


        If ( $disksizefreeGB -lt $disksizeGB*$disk_space_critical_percentage)
        {
        #Write-Host "Disk Space Alert: $env:computername Free Disk Space C: $FreeSpace GB and Total Disk Space $TotalSize GB" 

        $Body = "Disk Space Alert: $env:computername IP:$ipV4  Free Disk Space %10 of total Total Disk Space of C: $disksizeGB GB " 

        Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential

        }   

    
        }



         


 

