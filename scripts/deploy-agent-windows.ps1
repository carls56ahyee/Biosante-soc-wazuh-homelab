#Requires -RunAsAdministrator
param(
    [string]$WazuhManager = "192.168.30.105",
    [string]$AgentName    = "Windows-Client",
    [string]$AgentVersion = "4.7.5-1"
)

$ErrorActionPreference = "Stop"
$InstallerPath = Join-Path $env:TEMP "wazuh-agent.msi"
$DownloadUrl   = "https://packages.wazuh.com/4.x/windows/wazuh-agent-$AgentVersion.msi"

Write-Host "[*] Téléchargement de l'agent Wazuh $AgentVersion..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $DownloadUrl -OutFile $InstallerPath

Write-Host "[*] Installation silencieuse et enrôlement sur $WazuhManager..." -ForegroundColor Cyan
$MsiArgs = @(
    "/i", "`"$InstallerPath`"",
    "/q",
    "WAZUH_MANAGER=`"$WazuhManager`"",
    "WAZUH_AGENT_NAME=`"$AgentName`"",
    "WAZUH_REGISTRATION_SERVER=`"$WazuhManager`""
)
Start-Process msiexec.exe -Wait -ArgumentList $MsiArgs

Write-Host "[*] Démarrage du service Wazuh..." -ForegroundColor Cyan
Start-Service -Name Wazuh
Get-Service -Name Wazuh
