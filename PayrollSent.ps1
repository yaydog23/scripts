  
$month= (Get-Date).AddMonths(-1).ToString('MM')
$year= Get-Date -UFormat "%Y"



$From = ""
$SMTPServer = ""   
$SMTPPort = ""
$username = ''
$password = ''
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$Subject = "$year-$month Payroll "
$Body=Get-Content -Path "C:\Share\index.html" -Raw



$path= "D:\path\$year\$year-$month"


$user=(Get-ChildItem $path).FullName | % {[System.IO.Path]::GetFileNameWithoutExtension($_)}


Foreach ($i in $user)

{

Send-MailMessage -From $From -To "$i@emaildomain" -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer -port $SMTPPort -Attachments "$path\$i.pdf"  -Credential $credential -Bcc "bccemailinfouser"


}
