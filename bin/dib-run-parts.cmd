@echo off

powershell.exe -NonInteractive -ExecutionPolicy RemoteSigned -Command %~dp0dib-run-parts.ps1 %*