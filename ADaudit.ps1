#e mail parameters
$today= Get-Date -format "dd-MM-yyyy"
$When = ((Get-Date).AddDays(-1)).Date

$From = ""
$To = ""
$SMTPServer = ""   
$SMTPPort = ""
$username = ''
$password = 'XXX'
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)


#new created users

Get-ADUser -Filter {whenCreated -ge $When -and Enabled -eq $true}  -Properties * | Select-Object SamAccountName,whenCreated,EmailAddress >> C:\samuser.txt
 

#new created security groups

Get-ADGroup -Filter {whenCreated -ge $When -and GroupCategory -eq "Security" }  -Properties * | Select-Object SamAccountName,whenCreated,mail  >> C:\securitygroups.txt


#new created distribution groups

Get-ADGroup -Filter {whenCreated -ge $When -and GroupCategory -eq "Distribution" }  -Properties * | Select-Object SamAccountName,whenCreated,mail  >> C:\distributiongroups.txt



#users that changed passwords

Get-ADUser -Filter {PasswordLastSet -ge $When -and Enabled -eq $true}  -Properties * | Select-Object SamAccountName,whenChanged,EmailAddress >> C:\userpasswordchange.txt


#new domain join computers
Get-ADComputer -Filter {whenCreated -ge $When} -Properties DNSHostName,whenCreated | Select-Object DNSHostName,whenCreated >> C:\domainjoincomputers.txt


if (-not ([string]::IsNullOrEmpty("C:\samuser.txt")))

{

$Subject = "Active Directory Daily Audit Report: Created Users $today"

Send-MailMessage -From $From -to $To -Subject $Subject -Body "Attached"  -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential -Attachments "C:\samuser.txt" 

Remove-Item "C:\samuser.txt"

}


if (-not ([string]::IsNullOrEmpty("C:\securitygroups.txt")))

{

$Subject = "Active Directory Daily Audit Report: Created Security Groups $today"

Send-MailMessage -From $From -to $To -Subject $Subject -Body "Attached" -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential -Attachments "C:\securitygroups.txt"

Remove-Item "C:\securitygroups.txt"
}




if (-not ([string]::IsNullOrEmpty("C:\distributiongroups.txt")))

{

$Subject = "Active Directory Daily Audit Report: Created Distribution Groups $today"

Send-MailMessage -From $From -to $To -Subject $Subject -Body "Attached" -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential -Attachments "C:\distributiongroups.txt"

Remove-Item "C:\distributiongroups.txt"
}



if (-not ([string]::IsNullOrEmpty("C:\userpasswordchange.txt")))

{

$Subject = "Active Directory Daily Audit Report: User Changed Password $today"

Send-MailMessage -From $From -to $To -Subject $Subject -Body "Attached" -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential -Attachments "C:\userpasswordchange.txt"

Remove-Item "C:\userpasswordchange.txt"
}




if (-not ([string]::IsNullOrEmpty("C:\domainjoincomputers.txt")))

{

$Subject = "Active Directory Daily Audit Report: Domain Join Computers $today"

Send-MailMessage -From $From -to $To -Subject $Subject -Body "Attached" -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential -Attachments "C:\domainjoincomputers.txt"

Remove-Item "C:\domainjoincomputers.txt"
}


