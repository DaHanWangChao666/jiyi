@echo off
chcp 65001 >nul
title Clean repo - remove push scripts from GitHub
cd /d "%~dp0"

echo.
echo ==================================================
echo   Clean up the GitHub repo
echo ==================================================
echo.
echo   This will REMOVE these files from GitHub:
echo       GO.bat
echo       FIX-PUSH.bat
echo.
echo   They will STAY on your computer, so you can still
echo   use them to push updates later.
echo.
echo   Press any key to continue, or Ctrl+C to cancel.
pause >nul

echo.
echo Preparing...
git init -q 2>nul
git branch -M main 2>nul

if not exist ".gitignore" (
  echo GO.bat> .gitignore
  echo FIX-PUSH.bat>> .gitignore
)

git rm --cached GO.bat -q 2>nul
git rm --cached FIX-PUSH.bat -q 2>nul
git rm --cached PUSH.bat -q 2>nul
git rm --cached PUSH.ps1 -q 2>nul
git add -A
git -c user.email="DaHanWangChao666@users.noreply.github.com" -c user.name="DaHanWangChao666" commit -q -m "clean: remove local push scripts" 2>nul

git remote remove origin >nul 2>&1
git remote add origin https://github.com/DaHanWangChao666/jiyi.git

echo Pushing...
echo.
git push -u origin main
if errorlevel 1 goto FAILED

echo.
echo ==================================================
echo   DONE - repo cleaned
echo ==================================================
echo.
echo   The GitHub repo now contains only:
echo       .gitignore
echo       .nojekyll
echo       README.md
echo       index.html
echo.
echo   Open it to check:
echo       https://github.com/DaHanWangChao666/jiyi
echo.
echo   Your game:
echo       https://dahanwangchao666.github.io/jiyi/
echo.
start "" "https://github.com/DaHanWangChao666/jiyi"
pause
exit /b 0

:FAILED
echo.
echo ==================================================
echo   PUSH FAILED
echo ==================================================
echo.
echo   If it says "rejected" or "fetch first", run FIX-PUSH.bat
echo   Copy the error lines above and send them to me.
echo.
pause
exit /b 1
