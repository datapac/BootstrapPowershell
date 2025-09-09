$coreUrl = "https://raw.githubusercontent.com/datapac/bootstrappowershell/main/bootstrappowershell.ps1"
$coreFunctions = Invoke-WebRequest -Uri $coreUrl -UseBasicParsing
Invoke-Expression $coreFunctions.Content

Write-Info "Hello World"