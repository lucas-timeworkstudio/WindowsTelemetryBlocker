# Windows Telemetry Blocker

A lightweight, open-source toolkit to disable Windows telemetry and improve privacy on Windows 10 and 11 using PowerShell scripts.

## Usage

Run the main script using the provided `run.bat` file, which bypasses execution policies and elevates to admin permissions:

```
.\run.bat
```

Alternatively, run the PowerShell script directly:

```
.\windows-telemetry-blocker.ps1 -all
```

Or selectively run specific modules:

```
.\windows-telemetry-blocker.ps1 -modules telemetry,services
```

## Modules

- **telemetry.ps1**: Disables Windows Telemetry, feedback prompts, advertising ID, and Cortana.
- **services.ps1**: Disables DiagTrack, dmwappushsvc, RetailDemo, and Xbox Game Monitoring services.
- **apps.ps1**: Disables background apps, optionally removes bloatware, and disables Widgets/News/OneDrive auto-launch.
- **misc.ps1**: Disables Wi-Fi Sense, Timeline/Activity History, and cloud clipboard.

## Warning

This script requires administrative privileges to modify system settings. Run as administrator.
