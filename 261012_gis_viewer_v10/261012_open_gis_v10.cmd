@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0261012_open_gis_v10.ps1"
if errorlevel 1 pause
endlocal


