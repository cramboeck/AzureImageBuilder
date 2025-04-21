#region Logging
$logDir = "C:\Temp"
if (-not (Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory -Force | Out-Null
}

$logFile = Join-Path $logDir ("{0}_padt_install.log" -f (Get-Date -Format 'yyyyMMdd'))

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    "$timestamp - $message" | Out-File -FilePath $logFile -Append -Encoding UTF8
}
#endregion

#region Suche und Installation
$basePath = "C:\ImageBuilder"
Write-Log "🔍 Suche nach PSADT-Paketen in: $basePath"

# Hole alle Deploy-Application.exe-Dateien in Unterverzeichnissen
$padtPackages = Get-ChildItem -Path $basePath -Filter "Deploy-Application.exe" -Recurse -File -ErrorAction SilentlyContinue

foreach ($package in $padtPackages) {
    $packageFolder = $package.Directory.FullName
    Write-Log "📦 Starte Installation von Paket: $packageFolder"

    try {
        Start-Process -FilePath $package.FullName `
                      -ArgumentList "-DeploymentType Install -DeployMode Silent" `
                      -WorkingDirectory $packageFolder `
                      -Wait -ErrorAction Stop

        Write-Log "✅ Installation abgeschlossen: $packageFolder"
    }
    catch {
        Write-Log "❌ Fehler bei der Installation von $packageFolder: $_"
    }
}
#endregion

Write-Log "✅ Alle PSADT-Pakete wurden verarbeitet."
