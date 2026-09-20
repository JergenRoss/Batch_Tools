@ECHO OFF
:BEGIN
CLS

ECHO.
ECHO            @@  @@@@@@@@  @@     @@
ECHO            @@  @@        @@@@   @@
ECHO            @@  @@        @@ @@  @@
ECHO            @@  @@@@@     @@  @@ @@
ECHO      @@    @@  @@        @@   @@@@
ECHO      @@    @@  @@        @@     @@
ECHO        @@@@    @@@@@@@@  @@     @@
ECHO.

ECHO Choose options: [1/2/3/4/5/0]
ECHO 1 for Run the System File Checker tool with offline.
ECHO 2 for Scan the image to check for corruption with online.
ECHO 3 for Check the image to see whether any corruption has been detected with online.
ECHO 4 for To repair an image with offline.
ECHO 5 for To repair an image with online.
ECHO 6 for To repair a layout.ini with offline (take very long time than few hours)
ECHO 0 for exit

CHOICE /N /C:1234560 /m "Select key:%1"
	IF %ERRORLEVEL% EQU 7 GOTO 7
	IF %ERRORLEVEL% EQU 6 GOTO 6
	IF %ERRORLEVEL% EQU 5 GOTO 5
	IF %ERRORLEVEL% EQU 4 GOTO 4
	IF %ERRORLEVEL% EQU 3 GOTO 3
	IF %ERRORLEVEL% EQU 2 GOTO 2
	IF %ERRORLEVEL% EQU 1 GOTO 1
GOTO :EOF

:1
	ECHO Run the System File Checker tool with offline.
	ECHO processing...
		sfc /scannow
	pause
	GOTO :BEGIN

:2
	ECHO Scan the image to check for corruption with online.
	ECHO processing...
		Dism /Online /Cleanup-Image /ScanHealth
	pause
	GOTO :BEGIN

:3
	ECHO Check the image to see whether any corruption has been detected with online.
	ECHO processing...
		Dism /Online /Cleanup-Image /CheckHealth
	pause
	GOTO :BEGIN

:4
	ECHO To repair an image with offline.
	ECHO processing...
		Dism /Image:C:\offline /Cleanup-Image /RestoreHealth /Source:c:\test\mount\windows
	pause
	GOTO :BEGIN

:5
	ECHO To repair an image with online.
	ECHO processing...
		Dism /Online /Cleanup-Image /RestoreHealth /Source:c:\test\mount\windows /LimitAccess
	pause
	GOTO :BEGIN

:6
	ECHO To repair a layout.ini with offline
	ECHO The operation completed successfully. (you can close this window)
		Rundll32.exe advapi32.dll,ProcessIdleTasks
	ECHO The operation completed successfully.
	pause
	GOTO :BEGIN

:7
	choice /C:YN /T 5 /D y /M:"Are you sure you want to exit? y for yes or n for no, back to return"
		IF %ERRORLEVEL% EQU 2 GOTO :BEGIN
		IF %ERRORLEVEL% EQU 1 GOTO :EOF