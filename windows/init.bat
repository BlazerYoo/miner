@echo off
setlocal enabledelayedexpansion

:: Set working directory
set "WORKDIR=%USERPROFILE%\Downloads"

:: Set URLs
set "XMRIG_URL=https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-msvc-win64.zip"
set "XMRIG_ZIP=%WORKDIR%\xmrig-6.22.2-msvc-win64.zip"
set "XMRIG_EXPAND_DIR=%WORKDIR%\xmrig-6.22.2-msvc-win64"
set "XMRIG_DIR=%WORKDIR%\xmrig-6.22.2-msvc-win64\xmrig-6.22.2"

:: Download XMRig
echo ------------------------
echo 1. Downloading XMRig...
powershell -Command "Invoke-WebRequest -Uri '%XMRIG_URL%' -OutFile '%XMRIG_ZIP%'"
if errorlevel 1 (
    echo Download failed. Exiting.
    exit /b 1
)
echo Download successful: %XMRIG_ZIP%
echo ------------------------
echo.

:: Unzip XMRig
echo ------------------------
echo 2. Unzipping XMRig...
powershell -Command "Expand-Archive -Path '%XMRIG_ZIP%' -DestinationPath '%XMRIG_EXPAND_DIR%' -Force"
if errorlevel 1 (
    echo Extraction failed.
    exit /b 1
)
echo Extraction complete: %XMRIG_EXPAND_DIR%
echo ------------------------
echo.

:: Write config.json
echo ------------------------
echo Creating config.json...
(
echo {
echo     "autosave": true,
echo     "cpu": true,
echo     "opencl": false,
echo     "cuda": false,
echo     "pools": [
echo         {
echo             "url": "pool.supportxmr.com:443",
echo             "user": "XMR_ADDRESS",
echo             "pass": "PC",
echo             "keepalive": true,
echo             "tls": true
echo         }
echo     ]
echo }
) > "%XMRIG_DIR%\config.json"
echo Creating config.json complete: %XMRIG_DIR%\config.json
echo ------------------------
echo.

:: Run start.bat as administrator
echo Starting miner...
powershell -Command "Start-Process '%XMRIG_DIR%\start.bat' -Verb RunAs"

echo Done.
::timeout /t 3 >nul
