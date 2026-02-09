# Build MultiSwitchCXplorer (one-file)
$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here
Set-Location $root

$outputExe = Join-Path $root 'dist\MultiSwitchCXplorer.exe'
$outputExeExists = [System.IO.File]::Exists($outputExe)

# Avoid PyInstaller failing deep in EXE assembly when previous output is locked.
if ($outputExeExists) {
  $removed = $false
  for ($attempt = 1; $attempt -le 3 -and -not $removed; $attempt++) {
    try {
      Remove-Item -Path $outputExe -Force -ErrorAction Stop
      $removed = $true
    } catch {
      if ($attempt -lt 3) {
        Start-Sleep -Milliseconds 700
      }
    }
  }

  if (-not $removed) {
    $running = @(Get-Process -Name 'MultiSwitchCXplorer' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Id)
    if ($running.Count -gt 0) {
      throw "Cannot delete '$outputExe'. MultiSwitchCXplorer is still running (PID(s): $($running -join ', ')). Close it and rerun."
    }
    throw "Cannot delete '$outputExe'. It is likely locked by another process (Explorer preview, antivirus scan, etc.). Close anything using it and rerun."
  }
}

$pyinstaller = Get-Command pyinstaller -ErrorAction SilentlyContinue
if (-not $pyinstaller) {
  Write-Error 'PyInstaller not found. Install with: pip install pyinstaller'
}

pyinstaller --onefile --windowed `
  --name MultiSwitchCXplorer `
  --icon "assets\MultiSwitchCXplorer.ico" `
  --paths "src" `
  --hidden-import "ui" `
  --hidden-import "api" `
  --hidden-import "utils" `
  --add-data "assets\endpoints.json;assets" `
  --add-data "assets\saved_requests.json;assets" `
  --add-data "assets\MultiSwitchCXplorer.ico;assets" `
  --add-data "assets\MultiSwitchCXplorer.png;assets" `
  --add-data "assets\ArubaCXMultiAPI.png;assets" `
  "src\main.py"

if ($LASTEXITCODE -ne 0) {
  throw "PyInstaller build failed with exit code $LASTEXITCODE."
}

Write-Host "Build complete. Output: $root\dist\MultiSwitchCXplorer.exe"
