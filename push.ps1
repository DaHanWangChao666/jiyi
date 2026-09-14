# 一键推送脚本（PowerShell 版）
# 用法：在本文件夹里运行  .\push.ps1
#
# 这个脚本只做本地准备工作，最后一步"推送到 GitHub"由你执行——
# 因为我不能、也不应该碰你的账号凭证。

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host ""
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host "     记忆修复局 —— 推送到 GitHub" -ForegroundColor Cyan
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host ""

$user = "DaHanWangChao666"
$repo = "jiyi"

# 1) 检查 git
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
  Write-Host "  [错误] 没找到 git。请先安装 Git for Windows。" -ForegroundColor Red
  Read-Host "  按回车退出"; exit 1
}
Write-Host "  [1/5] git 已就绪" -ForegroundColor Green

# 2) 初始化仓库
if (-not (Test-Path ".git")) {
  git init -q
  git branch -M main
  Write-Host "  [2/5] 已初始化本地仓库" -ForegroundColor Green
} else {
  Write-Host "  [2/5] 本地仓库已存在" -ForegroundColor Green
}

# 3) 提交
git add -A
$msg = "记忆修复局 v0.1"
git -c user.email="$user@users.noreply.github.com" -c user.name="$user" commit -q -m $msg 2>$null
if ($LASTEXITCODE -eq 0) {
  Write-Host "  [3/5] 已提交" -ForegroundColor Green
} else {
  Write-Host "  [3/5] 没有新改动" -ForegroundColor Yellow
}

# 4) 绑定远程
$remote = git remote get-url origin 2>$null
if (-not $remote) {
  git remote add origin "https://github.com/$user/$repo.git"
  Write-Host "  [4/5] 已绑定远程仓库" -ForegroundColor Green
} else {
  Write-Host "  [4/5] 远程仓库已绑定: $remote" -ForegroundColor Green
}

# 5) 打开新建仓库页面
Write-Host "  [5/5] 打开 GitHub 新建仓库页面..." -ForegroundColor Green
Start-Process "https://github.com/new?name=$repo"

Write-Host ""
Write-Host "  ============================================" -ForegroundColor Yellow
Write-Host "    现在只剩两步（都要你自己做）：" -ForegroundColor Yellow
Write-Host "  ============================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "  ① 在刚打开的网页上建仓库：" -ForegroundColor White
Write-Host "       仓库名填：  $repo" -ForegroundColor White
Write-Host "       必须选：    Public" -ForegroundColor White
Write-Host "       不要勾任何 Add a ... 选项" -ForegroundColor White
Write-Host "       点 Create repository" -ForegroundColor White
Write-Host ""
Write-Host "  ② 建好之后，回到这个窗口运行：" -ForegroundColor White
Write-Host ""
Write-Host "       git push -u origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "     首次会弹出浏览器让你登录 GitHub，登录并授权即可（只此一次）" -ForegroundColor Gray
Write-Host ""
Write-Host "  ③ 推送成功后，去仓库的 Settings → Pages：" -ForegroundColor White
Write-Host "       Source 选 Deploy from a branch" -ForegroundColor White
Write-Host "       Branch 选 main，文件夹选 / (root)，点 Save" -ForegroundColor White
Write-Host ""
Write-Host "  ④ 等 1~2 分钟，你的游戏网址就是：" -ForegroundColor Green
Write-Host "       https://$user.github.io/$repo/" -ForegroundColor Green
Write-Host ""

Read-Host "  按回车退出"
