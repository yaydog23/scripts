
$searchbase="OU=Remote Users,DC=corendon-airlines,DC=com"
$grouptype="distribution"

$Groups = (Get-ADGroup -Properties * -Filter 'groupcategory -eq $grouptype' -SearchBase $searchbase ).samAccountName



Foreach($G In $Groups)
{
$users= (Get-ADGroupMember -Identity $G -Recursive |Get-ADObject -Properties DisplayName).Displayname 


if (-not ([string]::IsNullOrEmpty($users)))
{
write-output **************"USER LIST OF $G (BY DISPLAYNAME)"************* >> C:\users_$G.txt
write-output $users >> C:\users_$G.txt

}


}












