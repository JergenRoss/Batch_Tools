@ECHO OFF
for /F "tokens=*" %%A in (winget_install.txt) do (
	winget install --id %%A -e
	)

Pause