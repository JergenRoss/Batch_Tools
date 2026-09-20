@ECHO OFF
ECHO All
ECHO  0 of 5 processing...
	rammap -Ew
ECHO Empty Working Sets is The operation completed successfully. 1 of 5
ping 127.0.0.1 -n 2 > NUL
	rammap -Es
ECHO Empty System Working Sets is The operation completed successfully. 2 of 5
ping 127.0.0.1 -n 2 > NUL
	rammap -Em
ECHO Empty Modified Page List is The operation completed successfully. 3 of 5
ping 127.0.0.1 -n 2 > NUL
	rammap -Et
ECHO Empty Standby List is The operation completed successfully. 4 of 5
ping 127.0.0.1 -n 2 > NUL
	rammap -E0
ECHO Empty Priority 0 standby List is The operation completed successfully. 5 of 5
ECHO.
ECHO The All operation completed successfully.
ECHO.
timeout /t 2
