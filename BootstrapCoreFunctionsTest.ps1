$coreUrl = "https://raw.githubusercontent.com/Datapac/BootstrapPowershell/main/BootstrapCoreFunctions.ps1"
Write-Host "`$coreUrl=$coreUrl"

$coreFunctions = Invoke-WebRequest -Uri $coreUrl -UseBasicParsing
Write-Host "`$coreFunctions=$coreFunctions"
Write-Host "`$coreFunctions=$coreFunctions.Content"

#Invoke-Expression $coreFunctions.Content

#Write-Info "Hello World"