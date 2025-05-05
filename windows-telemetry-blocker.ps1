param(
    [switch]$all,
    [string[]]$modules,
    [switch]$interactive
)

# Function to create a system restore point
function Create-SystemRestorePoint {
    try {
        Write-Host "`nCreating system restore point..." -ForegroundColor Yellow
        $restorePointName = "Windows Telemetry Blocker - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        Checkpoint-Computer -Description $restorePointName -RestorePointType "APPLICATION_INSTALL"
        Write-Host "✓ System restore point created successfully!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "✗ Failed to create system restore point: $_" -ForegroundColor Red
        return $false
    }
}

# Function to check Windows version compatibility
function Test-WindowsVersion {
    $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
    $version = [Version]$osInfo.Version
    $minVersion = [Version]"10.0.19041" # Windows 10 2004 or later

    if ($version -lt $minVersion) {
        Write-Host "✗ Unsupported Windows version. This script requires Windows 10 2004 or later." -ForegroundColor Red
        return $false
    }
    Write-Host "✓ Windows version check passed" -ForegroundColor Green
    return $true
}

# Function to check PowerShell version
function Test-PowerShellVersion {
    $psVersion = $PSVersionTable.PSVersion
    $minVersion = [Version]"5.1"

    if ($psVersion -lt $minVersion) {
        Write-Host "✗ Unsupported PowerShell version. This script requires PowerShell 5.1 or later." -ForegroundColor Red
        return $false
    }
    Write-Host "✓ PowerShell version check passed" -ForegroundColor Green
    return $true
}

# Function to check for admin privileges
function Test-AdminPrivileges {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        Write-Host "✗ This script requires administrative privileges. Please run as administrator." -ForegroundColor Red
        return $false
    }
    Write-Host "✓ Administrative privileges confirmed" -ForegroundColor Green
    return $true
}

# Function to check for required Windows features
function Test-RequiredFeatures {
    $requiredFeatures = @(
        "Microsoft-Windows-SystemRestore",
        "Microsoft-Windows-PowerShell"
    )

    $missingFeatures = @()
    foreach ($feature in $requiredFeatures) {
        if (-not (Get-WindowsOptionalFeature -Online -FeatureName $feature -ErrorAction SilentlyContinue)) {
            $missingFeatures += $feature
        }
    }

    if ($missingFeatures.Count -gt 0) {
        Write-Host "✗ Missing required Windows features: $($missingFeatures -join ', ')" -ForegroundColor Red
        return $false
    }
    Write-Host "✓ Required Windows features check passed" -ForegroundColor Green
    return $true
}

# Run pre-execution checks
Write-Host "`n=== Running Pre-Execution Checks ===" -ForegroundColor Cyan

$checks = @(
    @{ Name = "Windows Version"; Function = { Test-WindowsVersion } },
    @{ Name = "PowerShell Version"; Function = { Test-PowerShellVersion } },
    @{ Name = "Admin Privileges"; Function = { Test-AdminPrivileges } },
    @{ Name = "Required Features"; Function = { Test-RequiredFeatures } }
)

$allChecksPassed = $true
foreach ($check in $checks) {
    Write-Host "`nChecking $($check.Name)..." -ForegroundColor Yellow
    if (-not (& $check.Function)) {
        $allChecksPassed = $false
    }
}

if (-not $allChecksPassed) {
    Write-Host "`n✗ Pre-execution checks failed. Please resolve the issues above and try again." -ForegroundColor Red
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Create system restore point
if (-not (Create-SystemRestorePoint)) {
    Write-Host "`n✗ Failed to create system restore point. Do you want to continue anyway? (Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -ne 'Y') {
        Write-Host "Operation cancelled by user." -ForegroundColor Yellow
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

$moduleList = @('telemetry', 'services', 'apps', 'misc')

function Show-Menu {
    Write-Host "`n=== Windows Telemetry Blocker ===" -ForegroundColor Cyan
    Write-Host "1. Default Mode (All Modules)" -ForegroundColor Yellow
    Write-Host "2. Custom Mode (Select Modules)" -ForegroundColor Yellow
    Write-Host "3. Exit" -ForegroundColor Red
    Write-Host "==============================`n"
}

function Show-ModuleSelection {
    Write-Host "`nAvailable Modules:" -ForegroundColor Cyan
    $i = 1
    foreach ($mod in $moduleList) {
        Write-Host "$i. $mod" -ForegroundColor Yellow
        $i++
    }
    Write-Host "`nSelect modules to run (comma-separated numbers, e.g., 1,3,4):"
}

function Get-UserSelection {
    $selection = Read-Host
    $selectedModules = @()
    $numbers = $selection -split ','
    
    foreach ($num in $numbers) {
        $index = [int]$num.Trim() - 1
        if ($index -ge 0 -and $index -lt $moduleList.Count) {
            $selectedModules += $moduleList[$index]
        }
    }
    return $selectedModules
}

if ($interactive) {
    do {
        Show-Menu
        $choice = Read-Host "Enter your choice (1-3)"
        
        switch ($choice) {
            "1" {
                $toRun = $moduleList
                break
            }
            "2" {
                Show-ModuleSelection
                $toRun = Get-UserSelection
                break
            }
            "3" {
                exit
            }
            default {
                Write-Host "Invalid choice. Please try again." -ForegroundColor Red
                continue
            }
        }
        
        if ($toRun.Count -gt 0) {
            Write-Host "`nSelected modules:" -ForegroundColor Green
            $toRun | ForEach-Object { Write-Host "- $_" -ForegroundColor Green }
            $confirm = Read-Host "`nProceed with selected modules? (Y/N)"
            if ($confirm -eq 'Y') {
                break
            }
        }
    } while ($true)
} elseif ($all) {
    $toRun = $moduleList
} elseif ($modules) {
    $toRun = $modules
} else {
    Write-Host "Specify -all, -modules <list>, or -interactive"
    exit 1
}

Write-Host "`n=== Starting Module Execution ===" -ForegroundColor Cyan
foreach ($mod in $toRun) {
    Write-Host "`nRunning module: $mod" -ForegroundColor Yellow
    try {
        . "$PSScriptRoot\modules\$mod.ps1"
        Write-Host "✓ Module $mod completed" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Error in module $mod : $_" -ForegroundColor Red
        Write-Host "Do you want to continue with remaining modules? (Y/N)" -ForegroundColor Yellow
        $response = Read-Host
        if ($response -ne 'Y') {
            Write-Host "Operation cancelled by user." -ForegroundColor Yellow
            Write-Host "Press any key to exit..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            exit 1
        }
    }
}

Write-Host "`n=== Operation Complete ===" -ForegroundColor Cyan
Write-Host "A system restore point was created before making changes." -ForegroundColor Green
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 