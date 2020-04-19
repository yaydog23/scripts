$username = 'o365adminemail'
$password = 'o365adminemailpasswd'
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)


$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid -Credential $credential -Authentication Basic -AllowRedirection

Import-PSSession -Session $Session -AllowClobber -DisableNameChecking

New-ComplianceSearch -Name "PhishingMail" -ExchangeLocation all -ContentMatchQuery 'subject:"PHISHINGEMAILSUBJECT"'



Start-ComplianceSearch -Identity "PhishingMail"


#get-ComplianceSearch -Identity "PhishingMail"


New-ComplianceSearchAction -SearchName "PhishingMail" -Purge -PurgeType SoftDelete


Get-PSSession | Remove-PSSession