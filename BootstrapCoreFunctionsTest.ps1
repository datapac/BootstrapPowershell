# Define the PUBLIC core url for BootstrapCoreFunctions.ps1
$coreUrl = "https://raw.githubusercontent.com/Datapac/BootstrapPowershell/main/BootstrapCoreFunctions.ps1"
Write-Host "`$coreUrl=$coreUrl"

# Test getting the core functions script
$coreFunctions = Invoke-WebRequest -Uri $coreUrl -UseBasicParsing
Write-Host "`$coreFunctions=$coreFunctions"

# Execute the core functions script to define my functions  
Invoke-Expression $coreFunctions.Content

# Test that my core functions are available
Write-Info "Hello World"
Write-Warning "Hello World Warning"
Write-ErrorMsg "Hello World Error"  
Write-Debug "Hello World Debug"  

Write-Success "*** End of BootstrapCoreFunctions.ps1 loaded successfully test ***"