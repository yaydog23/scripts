$From = "monitor@corendonairlines.com"
$To = "yaydog@corendon-airlines.com"
$SMTPServer = "mail.corendonairlines.com"   
$SMTPPort = "587"
$username = 'monitor'
$password = 'XX'
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$Subject = "Monitoring alert from $env:computername"


   #ports to monitor
   $ports=21,22


#port monitoring

               Foreach ($i in $ports)

        {

        $port_status=(Test-NetConnection -ComputerName localhost -InformationLevel Quiet -WarningAction SilentlyContinue -Port $i)





if ($port_status -eq $false)
        {
        

        $Body = "Port Alert: $env:computername $i port is closed"

        Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential



        }


        }

