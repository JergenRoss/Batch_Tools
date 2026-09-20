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

ECHO Choose options: [1/2/3/4/5/6/7/0]
ECHO 1 for All reset Network.
ECHO 2 for Resets the Winsock Catalog to a clean state.
ECHO 3 for Release the IPv4 address for the current adapter.
ECHO 4 for Renew the IPv4 address for the current adapter.
ECHO 5 for Resets the IPv4 configuration state.
ECHO 6 for Resets the IPv6 configuration state.
ECHO 7 for Displays NetBIOS over TCP/IP (NetBT) protocol statistics.
ECHO 0 for exit

CHOICE /N /C:12345670 /m "Select key:%1"
	IF %ERRORLEVEL% EQU 8 GOTO 8
	IF %ERRORLEVEL% EQU 7 GOTO 7
	IF %ERRORLEVEL% EQU 6 GOTO 6
	IF %ERRORLEVEL% EQU 5 GOTO 5
	IF %ERRORLEVEL% EQU 4 GOTO 4
	IF %ERRORLEVEL% EQU 3 GOTO 3
	IF %ERRORLEVEL% EQU 2 GOTO 2
	IF %ERRORLEVEL% EQU 1 GOTO 1
GOTO :EOF

:1
	ECHO "All reset Network."
	ECHO processing...
		netsh winsock reset
		ping 127.0.0.1 -n 5 > NUL
		netsh interface ipv4 reset
		ping 127.0.0.1 -n 5 > NUL
		netsh interface ipv6 reset
		ping 127.0.0.1 -n 5 > NUL
		ipconfig /release
		ping 127.0.0.1 -n 5 > NUL
		ipconfig /renew
		ping 127.0.0.1 -n 5 > NUL
		ipconfig /flushdns
		ping 127.0.0.1 -n 5 > NUL
	pause
	GOTO :BEGIN

:2
	ECHO "Resets the Winsock Catalog to a clean state."
	ECHO processing...
		netsh winsock reset
	pause
	GOTO :BEGIN

:3
	ECHO "Release the IPv4 address for the current adapter."
	ECHO processing...
		ipconfig /release
	pause
	GOTO :BEGIN

:4
	ECHO "Renew the IPv4 address for the current adapter."
	ECHO processing...
		ipconfig /renew
	pause
	GOTO :BEGIN

:5
	ECHO "Resets the IPv4 configuration state."
	ECHO processing...
		netsh interface ipv4 reset
	ECHO The operation completed successfully.
	pause
	GOTO :BEGIN
:6
	ECHO "Resets the IPv6 configuration state."
	ECHO processing...
		netsh interface ipv6 reset
	ECHO The operation completed successfully.
	pause
	GOTO :BEGIN
:7
	ECHO "Displays NetBIOS over TCP/IP (NetBT) protocol statistics."
	ECHO checking...
		nbtstat -r
	ECHO.
	pause
	GOTO :BEGIN

:8
	choice /C:YN /T 5 /D y /M:"Are you sure you want to exit? y for yes or n for no, back to return"
		IF %ERRORLEVEL% EQU 2 GOTO :BEGIN
		IF %ERRORLEVEL% EQU 1 GOTO :EOF