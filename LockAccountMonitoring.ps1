

#e mail parameters
   
$From = "monitor@corendonairline.com"
$To = "yaydog@corendon-airlines.com","kun@corendon-airlines.com","sgokcen@corendon-airlines.com","tkoksal@corendon-airlines.com"
$SMTPServer = "mail.corendonairline.com"   
$SMTPPort = "587"
$username = 'monitor'
$password = 'XXX'
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$Subject = "User Account Lock Alert"


$lockedaccounts_name=(Search-ADAccount –LockedOut -UsersOnly -SearchBase "DC=corendon-airlines,DC=com").Name 
$lockedaccounts_sam=(Search-ADAccount –LockedOut -UsersOnly -SearchBase "DC=corendon-airlines,DC=com").SamAccountName 

if (-not ([string]::IsNullOrEmpty($lockedaccounts_sam)))

{


$Body = "UserName: $lockedaccounts_name UserAccountName: $lockedaccounts_sam"

Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential

}







