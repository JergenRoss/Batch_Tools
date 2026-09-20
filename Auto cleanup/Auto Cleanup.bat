@ECHO OFF

for /F "tokens=*" %%A in ('dir /b ^| findstr /v /g:exclude.txt') do (
    del /f/s/q "%%A" > nul
    rd /s/q "%%A"
    echo cleaned up : "%%A"
    echo done
    )
Pause