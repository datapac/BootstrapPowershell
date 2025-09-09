# **********************************
# Load Bootstrap Core Functions needed to install GIT and Powershell
# Powershell 5,1 and above
# ********************************** 

Write-Info "*** Starting BootstrapPowershellInstall.ps1 ***"

# Define the PUBLIC core url for BootstrapCoreFunctions.ps1
$coreUrl = "https://raw.githubusercontent.com/Datapac/BootstrapPowershell/main/BootstrapCoreFunctions.ps1"
Write-Host "`$coreUrl=$coreUrl"

# Get the core functions script
$coreFunctions = Invoke-WebRequest -Uri $coreUrl -UseBasicParsing

# Execute the core functions script to define my functions  
Invoke-Expression $coreFunctions.Content

Write-Success "Bootstrap Core Functions Loaded"

# Define Current Working Directory (ScriptsRoot folder) and force creating new audit log file
$scriptsRootFolder = 'F:\Apps\DatapacMgt\ScriptsRoot'

# Ensure scripts and audit log will be in expected folder 'F:\Apps\DatapacMgt\ScriptsRoot'
try {

    New-Item -Path $scriptsRootFolder -ItemType Directory -Force | Out-Null

    # Set Current Working Directory
    Set-Location $scriptsRootFolder

    #Ensure audit log folder exists
    $logFolder = Join-Path $scriptsRootFolder 'Logs'
    New-Item -Path $logFolder -ItemType Directory -Force | Out-Null
    
    # Init audit log file
    $logFileName = "PowershellBootstrap_$(Get-Date -Format "yyMMdd-HHmmss").log"
    $logPath = Join-Path $logFolder $logFileName
    Write-Info 
    Write-Info "*** Begin PowershellBootstrap.ps1; creating audit log file in folder $logFolder named $logFileName ***"

} catch {

    Write-ErrorMsg "Create ScriptsRoot folder $scriptsRootFolder or audit log file $logPath aborted; $($_Exception.Message)"
    Exit 1

}


# Step 1: Install Git for Windows if not already installed
$retn = Read-Host "`nOK to install git (y/n)"
if ($retn -ieq 'y')
{
    Write-Info "Begin Git installation..."

    try {
        $gitLocation = (Get-Command git -ErrorAction Stop).Source
        Write-Info "Git already Installed:"
        Write-Info "  Git executable: $gitLocation"
        Write-Info "  Git directory: $((Get-Item $gitLocation).Directory.FullName)"

        # Validate and display existing user and email config values
        Validate-GitIdentity

        #Display existing git version
        git --version | Out-File -FilePath $logPath -Append


    } catch {
        # git not currently installed
        Write-Info "GIT not found in PATH; so it will be installed..."

        try {
            # Install git
            Install-GitOnWindows
        } catch {
            Write-ErrorMsg "Install-GitOnWindows() aborted; $($_Exception.Message)"
        }
    }
   
}


# Step: 2: Download scripts library using GIT CLONE 
$retn = Read-Host "`nOK to download scripts using GIT CLONE to folder $scriptsRootFolder (y/n)"
if ($retn -ieq 'y') {
    $repoLink = 'https://github.com/Datapac/Powershell.git'
    GitCloneRepoOnWindows $repoLink $scriptsRootFolder
}

# Step: 3: Download and install Powershell 7 
$retn = Read-Host "`nOK to download and install Powershell 7 (y/n)"
if ($retn -ieq 'y') {
    Install-Powershell7 "https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/PowerShell-7.5.2-win-x64.msi"
}

Write-Success "*** End of BootstrapPowershellInstall.ps1 ***"
