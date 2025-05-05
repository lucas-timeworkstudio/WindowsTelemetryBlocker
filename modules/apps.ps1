param(
    [switch]$RemoveBloatware
)

# Disable Background Apps
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1 -Type DWord

# Optionally remove preinstalled bloatware
if ($RemoveBloatware) {
    # Example: Remove Windows Store apps (adjust as needed)
    Get-AppxPackage -Name "Microsoft.WindowsStore" | Remove-AppxPackage
    Get-AppxPackage -Name "Microsoft.Office.OneNote" | Remove-AppxPackage
    # Add more bloatware removal commands as needed
}

# Disable Widgets / News / OneDrive auto-launch
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -Type DWord
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -Type DWord
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -Type DWord 