# Disable DiagTrack
Stop-Service -Name "DiagTrack" -Force
Set-Service -Name "DiagTrack" -StartupType Disabled

# Disable dmwappushsvc
Stop-Service -Name "dmwappushsvc" -Force
Set-Service -Name "dmwappushsvc" -StartupType Disabled

# Disable RetailDemo
Stop-Service -Name "RetailDemo" -Force
Set-Service -Name "RetailDemo" -StartupType Disabled

# Disable Xbox Game Monitoring
Stop-Service -Name "XblGameSave" -Force
Set-Service -Name "XblGameSave" -StartupType Disabled 