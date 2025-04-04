@echo off
setlocal

:: Define script paths (CHANGE THESE TO MATCH YOUR FILE LOCATIONS)
set "SETUP_SCRIPT=C:\path\to\setup_xmrig.bat"
set "CLEANUP_SCRIPT=C:\path\to\cleanup_xmrig.bat"

:: Schedule XMRig setup script at 9:10 PM
echo Scheduling XMRig setup script for 9:10 PM...
SCHTASKS /Create /TN "Run XMRig Setup" /TR "\"%SETUP_SCRIPT%\"" /SC ONCE /ST 21:10 /RL HIGHEST /F

:: Schedule cleanup script to run on startup (after reboot)
echo Scheduling Cleanup Script to run on startup...
SCHTASKS /Create /TN "Run Cleanup Script on Startup" /TR "\"%CLEANUP_SCRIPT%\"" /SC ONSTART /RL HIGHEST /F

:: Schedule system restart at 9:20 PM
echo Scheduling system restart for 9:20 PM...
SCHTASKS /Create /TN "Restart Computer" /TR "shutdown /r /t 0" /SC ONCE /ST 21:20 /RL HIGHEST /F

echo Task scheduling complete!
timeout /t 3 >nul
