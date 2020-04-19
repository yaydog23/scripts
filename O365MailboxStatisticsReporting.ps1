$From = ""
$To = ""
$SMTPServer = ""   
$SMTPPort = ""
$username1 = ''
$password1 = ''
$secpasswd1 = ConvertTo-SecureString $password1 -AsPlainText -Force
$credential1 = New-Object System.Management.Automation.PSCredential ($username1, $secpasswd1)


$date= $date=get-date -format "dd-MMM-yyyy"
$Subject = "Mailbox Statistics of $date"




$username2 = 'office365adminemail'
$password2 = 'office365adminemailpassword'
$secpasswd2 = ConvertTo-SecureString $password2 -AsPlainText -Force
$credential2 = New-Object System.Management.Automation.PSCredential ($username2, $secpasswd2)


$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid?DelegatedOrg=organizationname.onmicrosoft.com -Credential $credential2 -Authentication Basic -AllowRedirection -ErrorAction SilentlyContinue

Import-PSSession -Session $Session

$users= get-content -Path "C:\Scripts\o365users.txt"


Foreach ($i in $users)

{



Get-Mailbox -Identity $i  | Get-MailboxStatistics | Select-Object DisplayName, ItemCount, TotalItemSize   >> "C:\Scripts\mailbox.txt"


}

Send-MailMessage -From $From -to $To -Subject $Subject -Attachments "C:\Scripts\mailbox.txt" -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential1
Remove-Item "C:\Scripts\mailbox.txt" -Force

Remove-PSSession -Session $Session