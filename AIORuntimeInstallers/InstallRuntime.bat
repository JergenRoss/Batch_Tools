@ECHO OFF
CD /D "%~dp0"
FOR /F "delims=" %%i IN (runtime) DO (winget install %%i --accept-package-agreements --accept-source-agreements)
pause