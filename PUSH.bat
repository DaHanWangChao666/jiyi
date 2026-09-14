@echo off
chcp 65001 >nul
title Push to GitHub
cd /d "%~dp0"

echo.
echo ==================================================
echo   Push game to GitHub
echo ==================================================
echo.

git --version >nul 2>&1
if errorlevel 1 (
  echo [ERROR] git not found. Install from https://git-scm.com/download/win
  echo.
  pause
  exit /b 1
)
echo [OK] git found
echo.

echo --------------------------------------------------
echo  STEP 1: Create an EMPTY repo on GitHub
echo --------------------------------------------------
echo.
echo   Opening https://github.com/new ...
echo.
echo   On that page:
echo     - Repository name :  jiyi
echo     - Choose          :  Public
echo     - Do NOT tick any of the 3 checkboxes
echo     - Click           :  Create repository
echo.
echo   Then come back to this window.
echo.
start "" "https://github.com/new"
echo.
echo ==================================================
echo   Press any key AFTER you have created the repo
echo ==================================================
pause >nul

echo.
echo ------------------------------------------------
echo  STEP 2: Prepare local files
echo ------------------------------------------------
git init -q 2>nul
git branch -M main 2>nul
git add -A
git -c user.email="DaHanWangChao666@users.noreply.github.com" -c user.name="DaHanWangChao666" commit -q -m "update" 2>nul
git remote remove origin >nul 2>&1
git remote add origin https://github.com/DaHanWangChao666/jiyi.git
echo   Files ready. Remote = github.com/DaHanWangChao666/jiyi
echo.

echo ------------------------------------------------
echo  STEP 3: Push (a browser window will pop up)
echo ------------------------------------------------
echo.
echo   A browser window will ask you to sign in to GitHub.
echo   Sign in and click Authorize. Only needed once.
echo.
echo   Press any key to start pushing...
pause >nul
echo.
git push -u origin main
if errorlevel 1 goto FAILED

echo.
echo ==================================================
echo   SUCCESS!
echo ==================================================
echo.
echo   LAST STEP - turn on Pages (one time only):
echo.
echo     1) Open: https://github.com/DaHanWangChao666/jiyi/settings/pages
echo     2) Source : Deploy from a branch
echo     3) Branch : main     Folder : / (root)
echo     4) Click Save
echo     5) Wait 1-2 minutes
echo.
echo   Your game URL:
echo.
echo      https://dahanwangchao666.github.io/jiyi/
echo.
echo   Works on phone and PC. Share it with anyone.
echo.
start "" "https://github.com/DaHanWangChao666/jiyi/settings/pages"
pause
exit /b 0

:FAILED
echo.
echo ==================================================
echo   PUSH FAILED
echo ==================================================
echo.
echo   Common reasons:
echo.
echo   1) Repo not created yet
echo      Go to https://github.com/new and create a Public repo named  jiyi
echo.
echo   2) Repo is not empty (you ticked "Add a README")
echo      Delete README.md in the repo, then run this script again
echo.
echo   3) Sign-in was not completed
echo      Run this script again and finish the browser sign-in
echo.
echo   4) Network problem reaching GitHub
echo      Wait a few minutes and retry
echo.
echo   Copy the error lines above and send them to me.
echo.
pause
exit /b 1
