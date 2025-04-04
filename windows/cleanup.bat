@echo off
setlocal

:: Set working directory
set "WORKDIR=%USERPROFILE%\Documents"

:: Delete ZIP files
echo Deleting ZIP files...
del /f /q "%WORKDIR%\xmrig.zip"
del /f /q "%WORKDIR%\xmrig-cuda.zip"

:: Delete unzipped folders
echo Deleting xmrig-cuda folder...
rmdir /s /q "%WORKDIR%\xmrig-cuda"

echo Deleting xmrig miner folder...
rmdir /s /q "%WORKDIR%\xmrig"

echo Cleanup complete.
timeout /t 3 >nul
