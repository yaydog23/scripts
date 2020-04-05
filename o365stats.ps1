$From = "monitor@corendonairline.com"
$To = "yaydog@corendon-airlines.com","sgokcen@corendon-airlines.com","tkoksal@corendon-airlines.com","kun@corendon-airlines.com"
$SMTPServer = "mail.corendonairline.com"   
$SMTPPort = "587"
$username1 = 'monitor'
$password1 = 'XXX'
$secpasswd1 = ConvertTo-SecureString $password1 -AsPlainText -Force
$credential1 = New-Object System.Management.Automation.PSCredential ($username1, $secpasswd1)


$date= $date=get-date -format "dd-MMM-yyyy"
$Subject = "Mailbox Statistics of $date"




$username2 = 'admin@corendon365.onmicrosoft.com'
$password2 = 'COR148ayt!'
$secpasswd2 = ConvertTo-SecureString $password2 -AsPlainText -Force
$credential2 = New-Object System.Management.Automation.PSCredential ($username2, $secpasswd2)


$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid?DelegatedOrg=corendon365.onmicrosoft.com -Credential $credential2 -Authentication Basic -AllowRedirection -ErrorAction SilentlyContinue

Import-PSSession -Session $Session

$users= get-content -Path "C:\Scripts\o365users.txt"


Foreach ($i in $users)

{



Get-Mailbox -Identity $i  | Get-MailboxStatistics | Select-Object DisplayName, ItemCount, TotalItemSize   >> "C:\Scripts\mailbox.txt"


}

Send-MailMessage -From $From -to $To -Subject $Subject -Attachments "C:\Scripts\mailbox.txt" -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential1
Remove-Item "C:\Scripts\mailbox.txt" -Force

Remove-PSSession -Session $Session