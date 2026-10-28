@echo off
title SFA Portal 2.1 - Local Network Server
cd /d "%~dp0"
echo ============================================================
echo Starting SFA Portal 2.1 on Local Network IP...
echo ============================================================
node publish-local.js
pause
