@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title TheatreFlow Optimizer - Lukyamuzi Brian
color 0A

echo.
echo ========================================================
echo   THEATREFLOW OPTIMIZER - LUKYAMUZI BRIAN
echo ========================================================
echo.

where node >nul 2>nul
if errorlevel 1 (
  echo ERROR: Node.js was not found.
  echo Install Node.js LTS and run this file again.
  pause
  exit /b 1
)

for /f "tokens=5" %%P in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do (
  echo Closing old process %%P using port 8080...
  taskkill /PID %%P /F >nul 2>nul
)

if not exist node_modules (
  echo Installing required components. Please wait...
  call npm install
  if errorlevel 1 (
    echo.
    echo ERROR: Dependency installation failed.
    echo Keep this window open and send a photo of this message.
    pause
    exit /b 1
  )
)

echo.
echo Starting TheatreFlow...
start "TheatreFlow Browser" cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:8080"
node server.js

echo.
echo TheatreFlow stopped. If an error appeared above, send me a photo.
pause
