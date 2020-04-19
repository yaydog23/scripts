
((Get-Acl "D:\folder").Access) | Select-Object IdentityReference,FileSystemRights >> C:\FolderRights.csv