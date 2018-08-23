#Create testing user
1,2,3,4 | ForEach-Object -Process {
    try {New-LocalUser -Name "TestUser0$_" -NoPassword -Description "Test"} catch {}
}
<#
# The following code does not perform the way you would expect.
# This happens because on Remove-LocalUser, the LocalUser list shortens by one element.
# On the next loop iteration, it would then have progressed to the next object
# on the shortend list of objects.

Get-LocalUser | ForEach-Object -Process {
    if($_.Description -match 'Test') {
        Write-Host "User: $($_.Name)" ; Remove-LocalUser $_
    }
}
#>

#Initialize array object
Remove-Variable array
[System.Collections.ArrayList]$array = 0,0

#Get list of local testing users created, then delete from the list
Get-LocalUser | ForEach-Object -Process {if($_.Description -match "Test") {$array += "$($_.Name)"}}
$array.RemoveAt(0)
$array.RemoveAt(0)
$array | ForEach-Object -Process {Write-Host "User: $_" ; Remove-LocalUser $_}