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

	systeminfo |findstr "Memory"
ECHO.
ECHO "Choose options: [a/w/s/m/t/0/l/e]"
ECHO "a for All"
ECHO "q for All (EmptyStandbyList via schtasks)"
ECHO "w for Empty Working Sets"
ECHO "s for Empty System Working Sets"
ECHO "m for Empty Modified Page List"
ECHO "t for Empty Standby List"
ECHO "0 for Empty Priority 0 standby List"
ECHO "l for All loop"
ECHO "e for exit"
ECHO.

CHOICE /N /C:aqwsmt0le /m "Select key:%1"
	IF %ERRORLEVEL% EQU 9 GOTO :E
	IF %ERRORLEVEL% EQU 8 GOTO :L
	IF %ERRORLEVEL% EQU 7 GOTO :0
	IF %ERRORLEVEL% EQU 6 GOTO :T
	IF %ERRORLEVEL% EQU 5 GOTO :M
	IF %ERRORLEVEL% EQU 4 GOTO :S
	IF %ERRORLEVEL% EQU 3 GOTO :W
	IF %ERRORLEVEL% EQU 2 GOTO :Q
	IF %ERRORLEVEL% EQU 1 GOTO :A
GOTO :EOF

:A
	ECHO "All"
	ECHO "0 of 5 processing..."
		rammap -Ew
	ECHO "Empty Working Sets is The operation completed successfully. 1 of 5"
		rammap -Es
	ECHO "Empty System Working Sets is The operation completed successfully. 2 of 5"
		rammap -Em
	ECHO "Empty Modified Page List is The operation completed successfully. 3 of 5"
		rammap -Et
	ECHO "Empty Standby List is The operation completed successfully. 4 of 5"
		rammap -E0
	ECHO "Empty Priority 0 standby List is The operation completed successfully. 5 of 5"
	ECHO.
	ECHO "The All operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL
	GOTO :BEGIN

:Q
	ECHO "All"
	ECHO "EmptyStandbyList via schtasks is processing..."
		schtasks /run /tn \custom\EmptyStandbyList
	ECHO.
	ECHO "EmptyStandbyList via schtasks is The operation completed successfully."
	ECHO.
	ECHO "The All operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL
	GOTO :BEGIN

:W
	ECHO "Empty Working Sets"
	ECHO "processing, log:"
		rammap -Ew
	ECHO "Empty Working Sets is The operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL
	GOTO :BEGIN

:S
	ECHO "Empty System Working Sets"
	ECHO "processing, log:""
		rammap -Es
	ECHO "Empty System Working Sets is The operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL
	GOTO :BEGIN

:M
	ECHO "Empty Modified Page List"
	ECHO "processing, log:
		rammap -Em
	ECHO "Empty Modified Page List is The operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL
	GOTO :BEGIN

:t
	ECHO "Empty Standby List"
	ECHO "processing, log:"
		rammap -Et
	ECHO "Empty Standby List is The operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL
	GOTO :BEGIN

:0
	ECHO "Empty Priority 0 standby List"
	ECHO "processing, log:"
		rammap -E0
	ECHO "Empty Priority 0 standby List is The operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL
	GOTO :BEGIN

:L
	ECHO "1-5 for simple clean"
	ECHO "5-10 for strong clean"
	ECHO "10+ for extremely clean but warning: some not responding running background system app"
	ECHO.
	set /p n="Enter a number count the end loop:"
	ECHO %n%|findstr /r "[^0-9]" && (
		ECHO "ERROR: please enter a number only"
		timeout 5
		goto P
		)
	ECHO "processing..., please don't use other app // ctrl+c to stop this"
	for /l %%1 in (1, 1, %n%) do (
		rammap -Ew
		rammap -Es
		rammap -Em
		rammap -Et
		rammap -E0
		ECHO "passed %%1 of %n%, // Ctrl+C to stop"
		)
	ECHO.
	ECHO "The operation completed successfully."
	ECHO.
	ping 127.0.0.1 -n 5 > NUL

	GOTO :BEGIN

:E
	choice /C:YN /T 5 /D y /M:"Are you sure you want to exit? y for yes or n for no, back to return"
		IF %ERRORLEVEL% EQU 2 GOTO :BEGIN
		IF %ERRORLEVEL% EQU 1 GOTO :EOF
