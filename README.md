# 🛡️ Windows Telemetry Blocker

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-%3E%3D5.1-blue)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-blue)](https://www.microsoft.com/windows)
[![Version](https://img.shields.io/github/v/release/Lucas-timeworkstudio/WindowsTelemetryBlocker?include_prereleases&sort=semver)](https://github.com/Lucas-timeworkstudio/WindowsTelemetryBlocker/releases)
[![Downloads](https://img.shields.io/github/downloads/Lucas-timeworkstudio/WindowsTelemetryBlocker/total)](https://github.com/Lucas-timeworkstudio/WindowsTelemetryBlocker/releases)
[![Issues](https://img.shields.io/github/issues/Lucas-timeworkstudio/WindowsTelemetryBlocker)](https://github.com/Lucas-timeworkstudio/WindowsTelemetryBlocker/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/Lucas-timeworkstudio/WindowsTelemetryBlocker)](https://github.com/Lucas-timeworkstudio/WindowsTelemetryBlocker/pulls)
[![Last Commit](https://img.shields.io/github/last-commit/Lucas-timeworkstudio/WindowsTelemetryBlocker)](https://github.com/Lucas-timeworkstudio/WindowsTelemetryBlocker/commits/main)
[![Code Size](https://img.shields.io/github/languages/code-size/Lucas-timeworkstudio/WindowsTelemetryBlocker)](https://github.com/Lucas-timeworkstudio/WindowsTelemetryBlocker)

A lightweight, open-source toolkit to disable Windows telemetry and improve privacy on Windows 10 and 11 using PowerShell scripts. Inspired by tools like ShutUp10++, but fully transparent and scriptable.

## ✨ Features

- 🔒 Disable Windows Telemetry
- 🚫 Block Feedback & Advertising
- 🛑 Stop Unnecessary Services
- 🗑️ Remove Bloatware (Optional)
- 🎯 Interactive Module Selection
- 🔄 Easy to Use & Maintain

## 🚀 Quick Start

1. Download the latest release
2. Run `run.bat` as administrator
3. Choose your preferred mode:
   - Default Mode: Run all modules
   - Custom Mode: Select specific modules

## 📋 Usage

### Interactive Mode (Recommended)
```powershell
.\run.bat
```

### Command Line Options
```powershell
# Run all modules
.\windows-telemetry-blocker.ps1 -all

# Run specific modules
.\windows-telemetry-blocker.ps1 -modules telemetry,services

# Interactive mode
.\windows-telemetry-blocker.ps1 -interactive
```

## 🧩 Modules

| Module | Description |
|--------|-------------|
| **telemetry.ps1** | Disables Windows Telemetry, feedback prompts, advertising ID, and Cortana |
| **services.ps1** | Disables DiagTrack, dmwappushsvc, RetailDemo, and Xbox Game Monitoring |
| **apps.ps1** | Disables background apps, removes bloatware (optional), and disables Widgets/News/OneDrive |
| **misc.ps1** | Disables Wi-Fi Sense, Timeline/Activity History, and cloud clipboard |

## ⚠️ Warning

This script requires administrative privileges to modify system settings. Always run as administrator.

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by [ShutUp10++](https://www.oo-software.com/en/shutup10)
- Thanks to all contributors and the open-source community
