

$From = "it@corendon-airlines.com"
$SMTPServer = "smtp.office365.com"   
$SMTPPort = "587"
$username = 'it@corendon-airlines.com'
$password = 'XXX'
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$Subject = "User Password Change Reminder"
$Body= Get-Content -Path "C:\share\passwordchange.html" -Raw


$account_mail= (get-aduser -filter {Enabled -eq $true} -SearchBase "OU=Ayt-Head-Off,DC=corendon-airlines,DC=com"-SearchScope Subtree   -properties * | where {$_.passwordlastset -lt (get-date).adddays(-180)} ).EmailAddress


Foreach ($i in $account_mail)

{

Send-MailMessage -From $From -to $i -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential -ErrorAction SilentlyContinue -UseSsl


}


#Send-MailMessage -From $From -to "yaydog@corendon-airlines.com" -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential -ErrorAction SilentlyContinue
#get-aduser -filter {Enabled -eq $true}  -SearchBase "OU=Ayt-Head-Off,DC=corendon-airlines,DC=com" -SearchScope Subtree  -properties * | where {$_.passwordlastset -lt (get-date).adddays(-180)  }  | ft SamAccountName,EmailAddress,DisplayName,PasswordLastSet