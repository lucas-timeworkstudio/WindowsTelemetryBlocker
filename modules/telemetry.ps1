# Disable Windows Telemetry
try {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -ErrorAction Stop
    Write-Host "✓ Disabled Windows Telemetry" -ForegroundColor Green
}
catch {
    Write-Host "✗ Failed to disable Windows Telemetry: $_" -ForegroundColor Red
    throw
}

# Turn off Feedback prompts
try {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0 -Type DWord -ErrorAction Stop
    Write-Host "✓ Disabled Feedback prompts" -ForegroundColor Green
}
catch {
    Write-Host "✗ Failed to disable Feedback prompts: $_" -ForegroundColor Red
    throw
}

# Disable Advertising ID
try {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Type DWord -ErrorAction Stop
    Write-Host "✓ Disabled Advertising ID" -ForegroundColor Green
}
catch {
    Write-Host "✗ Failed to disable Advertising ID: $_" -ForegroundColor Red
    throw
}

# Disable Cortana
try {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord -ErrorAction Stop
    Write-Host "✓ Disabled Cortana" -ForegroundColor Green
}
catch {
    Write-Host "✗ Failed to disable Cortana: $_" -ForegroundColor Red
    throw
} 