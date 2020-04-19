

#e mail parameters
   
$From = ""
$To = ""
$SMTPServer = ""   
$SMTPPort = ""
$username = ''
$password = ''
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$Subject = "User Account Lock Alert"


$lockedaccounts_name=(Search-ADAccount –LockedOut -UsersOnly -SearchBase "DC=dc,DC=com").Name 
$lockedaccounts_sam=(Search-ADAccount –LockedOut -UsersOnly -SearchBase "DC=dc,DC=com").SamAccountName 

if (-not ([string]::IsNullOrEmpty($lockedaccounts_sam)))

{


$Body = "UserName: $lockedaccounts_name UserAccountName: $lockedaccounts_sam"

Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -Credential $credential

}







