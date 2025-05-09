param (
    [string]$csvUrl = "https://<default-storage>.blob.core.windows.net/packages/default.csv"
)

Write-Output "### Starte Softwareinstallation von $csvUrl ###"

# CSV herunterladen
$tempCsv = "$env:TEMP\packages.csv"
Invoke-WebRequest -Uri $csvUrl -OutFile $tempCsv

# CSV einlesen
$packages = Import-Csv -Path $tempCsv

# Chocolatey installieren, falls nicht vorhanden
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Chocolatey wird installiert..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

foreach ($pkg in $packages) {
    switch ($pkg.Source.ToLower()) {
        "choco" {
            Write-Output "Installiere $($pkg.Name) mit Chocolatey..."
            choco install $($pkg.Name) -y --no-progress
        }
        "winget" {
            if (Get-Command winget -ErrorAction SilentlyContinue) {
                Write-Output "Installiere $($pkg.Name) mit Winget..."
                winget install --id $($pkg.Name) --accept-source-agreements --accept-package-agreements -e
            } else {
                Write-Warning "Winget nicht verfügbar. $($pkg.Name) wird übersprungen."
            }
        }
        default {
            Write-Warning "Unbekannte Quelle '$($pkg.Source)' für $($pkg.Name). Wird übersprungen."
        }
    }
}

Write-Output "### Softwareinstallation abgeschlossen ###"

