@ECHO OFF
for /F "tokens=*" %%A in (winget_upgrade.txt) do (
	winget upgrade --id %%A -e
	)

Pause