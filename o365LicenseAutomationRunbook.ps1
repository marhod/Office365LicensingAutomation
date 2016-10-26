$domainName = "mrhodes.net"
$azureCredentialName = "mod272526"


$cred = Get-AutomationPSCredential -Name $azureCredentialName
Connect-MsolService -Credential $cred

$Location = "AU"

Get-MsolUser -DomainName $domainName | Where-Object -FilterScript {$_.UsageLocation -ne $location} | Set-MsolUser -UsageLocation $location
$users = Get-MsolUser -DomainName "mrhodes.net"

$license = (Get-MsolAccountSku).AccountSkuID

foreach ($user in $users) {
    if (!$user.IsLicensed) {
        Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName -AddLicenses $license
    }
}
