@echo off
chcp 65001 >nul
title 记忆修复局 —— 推送到 GitHub
cd /d "%~dp0"

echo.
echo  ============================================
echo     记忆修复局 —— 一键推送到 GitHub
echo  ============================================
echo.

git --version >nul 2>&1
if errorlevel 1 (
  echo  [错误] 没找到 git，请先安装 Git for Windows
  echo          https://git-scm.com/download/win
  echo.
  pause
  exit /b 1
)

echo  正在检查本地仓库...
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
  echo  [提示] 本地仓库不存在，正在初始化...
  git init -q
  git branch -M main
  git add -A
  git -c user.email="DaHanWangChao666@users.noreply.github.com" -c user.name="DaHanWangChao666" commit -q -m "记忆修复局 v0.1"
  git remote add origin https://github.com/DaHanWangChao666/jiyi.git
  echo         完成
) else (
  echo         本地仓库已就绪
  git add -A
  git -c user.email="DaHanWangChao666@users.noreply.github.com" -c user.name="DaHanWangChao666" commit -q -m "更新" 2>nul
)

echo.
echo  ============================================
echo    接下来只需要两步：
echo  ============================================
echo.
echo  【第一步】在浏览器里建一个空仓库
echo.
echo      马上会打开 https://github.com/new
echo      如果没自动打开，请手动访问上面这个网址
echo.
echo        仓库名填：  jiyi
echo        必须选：    Public
echo        不要勾选任何 "Add a ..." 选项
echo        点绿色的 Create repository
echo.
echo      建好之后，【不要】关掉浏览器
echo.
echo  【第二步】回到这个窗口，按任意键开始推送
echo.
echo      首次推送会弹出一个浏览器窗口
echo      让你登录 GitHub 并授权 —— 登录一次就好
echo.
pause >nul

echo.
echo  正在推送到 github.com/DaHanWangChao666/jiyi ...
echo.
git push -u origin main

if errorlevel 1 (
  echo.
  echo  ============================================
  echo    推送失败，常见原因：
  echo  ============================================
  echo.
  echo  1. 还没建仓库       -^> 先去 https://github.com/new 建一个叫 jiyi 的公开仓库
  echo  2. 仓库名不对       -^> 必须是 jiyi，全小写
  echo  3. 登录没完成       -^> 重新运行本脚本，在弹出的窗口里完成登录
  echo  4. 仓库不是空的     -^> 如果你建仓库时勾了 README，先删掉那个文件再试
  echo.
  echo  把上面的报错信息复制给我，我来帮你看。
  echo.
  pause
  exit /b 1
)

echo.
echo  ============================================
echo    推送成功！
echo  ============================================
echo.
echo  最后一步：开启 Pages（只需做一次）
echo.
echo    1. 打开 https://github.com/DaHanWangChao666/jiyi/settings/pages
echo    2. Source 选：Deploy from a branch
echo    3. Branch 选：main      文件夹选：/ (root)
echo    4. 点 Save
echo    5. 等 1~2 分钟
echo.
echo  你的游戏网址：
echo.
echo      https://dahanwangchao666.github.io/jiyi/
echo.
echo  手机上也能打开，可以直接发给朋友。
echo.
start "" "https://github.com/DaHanWangChao666/jiyi/settings/pages"
pause
