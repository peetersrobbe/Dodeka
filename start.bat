@echo off
title Dodeka - lokale testserver
cd /d "%~dp0"
set PORT=8000

echo ==================================================
echo   Dodeka Sport - lokale testserver
echo   Adres: http://localhost:%PORT%
echo.
echo   LET OP: dit gebruikt de ECHTE Supabase-database.
echo   Opslaan wijzigt de echte gegevens.
echo.
echo   Sluit dit venster (of Ctrl+C) om te stoppen.
echo ==================================================
echo.

where python >nul 2>nul
if %errorlevel%==0 (
  start "" "http://localhost:%PORT%/login.html"
  python -m http.server %PORT%
  goto :eof
)

where py >nul 2>nul
if %errorlevel%==0 (
  start "" "http://localhost:%PORT%/login.html"
  py -m http.server %PORT%
  goto :eof
)

where npx >nul 2>nul
if %errorlevel%==0 (
  start "" "http://localhost:%PORT%/login.html"
  npx --yes http-server -p %PORT% -c-1
  goto :eof
)

echo Geen Python of Node.js gevonden.
echo Installeer Python via https://www.python.org/downloads/
echo (vink "Add python.exe to PATH" aan) en probeer opnieuw.
pause
