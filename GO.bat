@echo off
chcp 65001 >nul
title Push to GitHub - jiyi
cd /d "%~dp0"

echo.
echo ==================================================
echo   Pushing to github.com/DaHanWangChao666/jiyi
echo ==================================================
echo.

git --version >nul 2>&1
if errorlevel 1 (
  echo [ERROR] git not found. Install: https://git-scm.com/download/win
  pause
  exit /b 1
)

echo [1/3] Preparing files...
git init -q 2>nul
git branch -M main 2>nul
git add -A
git -c user.email="DaHanWangChao666@users.noreply.github.com" -c user.name="DaHanWangChao666" commit -q -m "update" 2>nul
git remote remove origin >nul 2>&1
git remote add origin https://github.com/DaHanWangChao666/jiyi.git
echo       done

echo [2/3] Pushing... (a GitHub sign-in window may pop up)
echo.
git push -u origin main
if errorlevel 1 goto FAILED

echo.
echo [3/3] SUCCESS
echo.
echo ==================================================
echo   Your game URL:
echo.
echo      https://dahanwangchao666.github.io/jiyi/
echo ==================================================
echo.
echo   If the URL shows 404, do this ONE time:
echo.
echo     1) Open: https://github.com/DaHanWangChao666/jiyi/settings/pages
echo     2) Source : Deploy from a branch
echo     3) Branch : main     Folder : / (root)
echo     4) Click Save, then wait 1-2 minutes
echo.
start "" "https://github.com/DaHanWangChao666/jiyi/settings/pages"
echo.
pause
exit /b 0

:FAILED
echo.
echo ==================================================
echo   PUSH FAILED
echo ==================================================
echo.
echo   Read the error lines above. Most likely:
echo.
echo   A) "Authentication failed"
echo      -> the sign-in window was closed. Run again.
echo.
echo   B) "rejected ... fetch first"  or  "unrelated histories"
echo      -> your repo already has a file (like a README).
echo         Run the file  FIX-PUSH.bat  instead.
echo.
echo   C) "Could not resolve host" / timeout
echo      -> cannot reach GitHub right now. Try again later.
echo.
pause
exit /b 1
