# ============================================================
#  一键推送到 GitHub（PowerShell 版）
#  用法：右键这个文件 → 「使用 PowerShell 运行」
#     或：在本文件夹按住 Shift + 右键 → 在此处打开 PowerShell → .\PUSH.ps1
# ============================================================

$ErrorActionPreference = 'Continue'
Set-Location $PSScriptRoot

$user = 'DaHanWangChao666'
$repo = 'jiyi'
$url  = "https://$($user.ToLower()).github.io/$repo/"

function Line { Write-Host ('-' * 52) -ForegroundColor DarkGray }
function Head($t) { Write-Host ''; Line; Write-Host "  $t" -ForegroundColor Cyan; Line }

Write-Host ''
Write-Host '  ==================================================' -ForegroundColor Cyan
Write-Host '     Push game to GitHub' -ForegroundColor Cyan
Write-Host '  ==================================================' -ForegroundColor Cyan

# --- 0. 检查 git ---
Head 'Checking git'
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
  Write-Host '  [ERROR] git not found.' -ForegroundColor Red
  Write-Host '          Install: https://git-scm.com/download/win' -ForegroundColor Red
  Read-Host '  Press Enter to exit'; exit 1
}
Write-Host '  [OK] git found' -ForegroundColor Green

# --- 1. 提示建仓库 ---
Head 'STEP 1 - Create an EMPTY repo on GitHub'
Write-Host '  Opening https://github.com/new ...'
Write-Host ''
Write-Host '  On that page:' -ForegroundColor Yellow
Write-Host '    Repository name :  jiyi'
Write-Host '    Choose          :  Public'
Write-Host '    Do NOT tick any of the 3 checkboxes'
Write-Host '    Click           :  Create repository'
Write-Host ''
Start-Process 'https://github.com/new'
Read-Host '  Press Enter AFTER the repo is created'

# --- 2. 准备本地文件 ---
Head 'STEP 2 - Preparing local files'
git init -q 2>$null
git branch -M main 2>$null
git add -A
git -c user.email="$user@users.noreply.github.com" -c user.name="$user" commit -q -m 'update' 2>$null
git remote remove origin 2>$null | Out-Null
git remote add origin "https://github.com/$user/$repo.git"
Write-Host "  Files ready. Remote = github.com/$user/$repo" -ForegroundColor Green

# --- 3. 推送 ---
Head 'STEP 3 - Pushing (a browser window will pop up)'
Write-Host '  A browser window will ask you to sign in to GitHub.'
Write-Host '  Sign in and click Authorize. Only needed once.'
Write-Host ''
Read-Host '  Press Enter to start pushing'
Write-Host ''
git push -u origin main

if ($LASTEXITCODE -ne 0) {
  Write-Host ''
  Write-Host '  ==================================================' -ForegroundColor Red
  Write-Host '     PUSH FAILED' -ForegroundColor Red
  Write-Host '  ==================================================' -ForegroundColor Red
  Write-Host ''
  Write-Host '  Common reasons:'
  Write-Host '   1) Repo not created yet'
  Write-Host '      -> https://github.com/new  create Public repo named jiyi'
  Write-Host '   2) Repo is not empty (you ticked "Add a README")'
  Write-Host '      -> delete README.md in the repo, run again'
  Write-Host '   3) Sign-in not completed'
  Write-Host '      -> run again and finish the browser sign-in'
  Write-Host '   4) Cannot reach GitHub (network)'
  Write-Host '      -> wait a few minutes and retry'
  Write-Host ''
  Write-Host '  Copy the error lines above and send them to me.' -ForegroundColor Yellow
  Write-Host ''
  Read-Host '  Press Enter to exit'
  exit 1
}

# --- 4. 成功 ---
Head 'SUCCESS'
Write-Host ''
Write-Host '  LAST STEP - turn on Pages (one time only):' -ForegroundColor Yellow
Write-Host ''
Write-Host "    1) Open: https://github.com/$user/$repo/settings/pages"
Write-Host '    2) Source : Deploy from a branch'
Write-Host '    3) Branch : main        Folder : / (root)'
Write-Host '    4) Click Save'
Write-Host '    5) Wait 1-2 minutes'
Write-Host ''
Write-Host '  Your game URL:' -ForegroundColor Green
Write-Host ''
Write-Host "     $url" -ForegroundColor Green
Write-Host ''
Write-Host '  Works on phone and PC. Share it with anyone.'
Write-Host ''
Start-Process "https://github.com/$user/$repo/settings/pages"
Read-Host '  Press Enter to exit'
