@echo off
setlocal enabledelayedexpansion

:: Set working directory
set "WORKDIR=%USERPROFILE%\Documents"

:: Set URLs
set "XMRIG_URL=https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-msvc-win64.zip"
set "CUDA_URL=https://github.com/xmrig/xmrig-cuda/releases/download/v6.22.0/xmrig-cuda-6.22.0-cuda12_4-win64.zip"

:: Set file names
set "XMRIG_ZIP=%WORKDIR%\xmrig.zip"
set "CUDA_ZIP=%WORKDIR%\xmrig-cuda.zip"

:: Download XMRig
echo Downloading XMRig...
powershell -Command "Invoke-WebRequest -Uri '%XMRIG_URL%' -OutFile '%XMRIG_ZIP%'"

:: Download CUDA plugin
echo Downloading XMRig CUDA plugin...
powershell -Command "Invoke-WebRequest -Uri '%CUDA_URL%' -OutFile '%CUDA_ZIP%'"

:: Unzip XMRig
echo Unzipping XMRig...
powershell -Command "Expand-Archive -Path '%XMRIG_ZIP%' -DestinationPath '%WORKDIR%\xmrig' -Force"

:: Unzip CUDA plugin
echo Unzipping CUDA plugin...
powershell -Command "Expand-Archive -Path '%CUDA_ZIP%' -DestinationPath '%WORKDIR%\xmrig-cuda' -Force"

:: Copy CUDA plugin files (excluding SHA256SUMS)
echo Copying CUDA plugin files (excluding SHA256SUMS) into XMRig folder...
for /R "%WORKDIR%\xmrig-cuda" %%F in (*) do (
    echo %%~nxF | findstr /I /C:"SHA256SUMS" >nul
    if errorlevel 1 (
        copy /Y "%%F" "%WORKDIR%\xmrig\xmrig-6.22.2\"
    )
)

:: Write config.json
echo Creating config.json...
> "%WORKDIR%\xmrig\xmrig-6.22.2\config.json" (
echo {
echo     "autosave": true,
echo     "cpu": true,
echo     "opencl": false,
echo     "cuda": true,
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
)

:: Run start.bat as administrator
echo Starting miner...
powershell -Command "Start-Process '%WORKDIR%\xmrig\xmrig-6.22.2\start.bat' -Verb RunAs"

echo Done.
timeout /t 3 >nul
