@echo off
chcp 65001 >nul
title FIX - force push to jiyi
cd /d "%~dp0"

echo.
echo ==================================================
echo   FORCE push to github.com/DaHanWangChao666/jiyi
echo ==================================================
echo.
echo   Use this if GO.bat failed with
echo   "rejected" or "unrelated histories".
echo.
echo   WARNING: this will REPLACE everything in that repo
echo   with the game files. Any file you put there will be lost.
echo.
echo   Press Ctrl+C to cancel, or
pause

echo.
echo Preparing...
git init -q 2>nul
git branch -M main 2>nul
git add -A
git -c user.email="DaHanWangChao666@users.noreply.github.com" -c user.name="DaHanWangChao666" commit -q -m "memory repair bureau v0.1" 2>nul
git remote remove origin >nul 2>&1
git remote add origin https://github.com/DaHanWangChao666/jiyi.git

echo Pushing (force)...
echo.
git push -u origin main --force
if errorlevel 1 goto FAILED

echo.
echo ==================================================
echo   SUCCESS
echo ==================================================
echo.
echo   Your game URL:
echo.
echo      https://dahanwangchao666.github.io/jiyi/
echo.
echo   If it shows 404, enable Pages once:
echo      https://github.com/DaHanWangChao666/jiyi/settings/pages
echo      Source: Deploy from a branch
echo      Branch: main    Folder: / (root)    Save
echo.
start "" "https://github.com/DaHanWangChao666/jiyi/settings/pages"
pause
exit /b 0

:FAILED
echo.
echo PUSH FAILED - copy the error lines above and send them to me.
echo.
pause
exit /b 1
