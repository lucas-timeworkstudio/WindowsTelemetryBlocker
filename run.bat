@echo off
powershell -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File \"%~dp0windows-telemetry-blocker.ps1\" -interactive' -Verb RunAs" 