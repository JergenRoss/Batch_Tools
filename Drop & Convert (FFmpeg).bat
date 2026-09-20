@echo off
:: Debug Header: Fixed for paths containing spaces
if not defined DEBUG_MODE (
    set "DEBUG_MODE=1"
    cmd /k ""%~f0" %*"
    exit /b
)
setlocal EnableDelayedExpansion
:again
cls
echo Welcome to FFmpeg tools built-in batch file by Jergen Ross and AI generated.
echo.

REM Check if at least one file was dropped
if "%~1"=="" (
    echo No file provided. Please drag and drop one or more files onto this script.
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

echo Processing dropped files...
echo -------------------------

REM Loop through and print details for dropped files
for %%F in (%*) do (
    if exist "%%~fF" (
        echo File path: %%~fF
        echo File name: %%~nxF
        echo Directory: %%~dpF
        echo Name:      %%~nF
        echo Extension: %%~xF
        echo -------------------------
        
        REM Backup file
        if not exist "backup" mkdir "backup"
        copy "%%~fF" "backup\" >nul
    ) else (
        echo Skipped: %%~fF (file not found)
    )
)

echo.
echo What do you want to do with the file(s)?
echo 1. Compress
echo 2. Convert
choice /C 12 /M "Select option:"

if errorlevel 2 goto convert
if errorlevel 1 goto compress

:compress
echo.
echo --- FFmpeg Compression ---
for %%F in (%*) do (
    if exist "%%~fF" (
        set "rename="
        set /p "rename=Rename for '%%~nxF' (Press ENTER to keep '%%~nF'): "
        if "!rename!"=="" set "rename=%%~nF"

        echo Starting compress: "%%~fF" --^> "%%~dpF!rename!%%~xF"
        ffmpeg -i "%%~fF" -c:v libx264 -crf 28 -preset slow -vf "scale=-2:720" -c:a aac -b:a 96k "%%~dpF!rename!%%~xF"
        echo -------------------------
    )
)
goto done

:convert
echo.
echo --- FFmpeg Extension Converter ---
set /p "extension=Input target extension without dot (e.g., gif, mp3, mp4): "

for %%F in (%*) do (
    if exist "%%~fF" (
        set "rename="
        set /p "rename=Rename for '%%~nxF' (Press ENTER to keep '%%~nF'): "
        if "!rename!"=="" set "rename=%%~nF"

        echo Starting convert: "%%~fF" --^> "%%~dpF!rename!.!extension!"
        ffmpeg -i "%%~fF" -vf fps=15 "%%~dpF!rename!.!extension!"
        echo -------------------------
    )
)
goto done

:done
echo.
echo All tasks finished.
echo.
echo Do you want to run another operation on these files?
echo 1. Yes
echo 2. No
choice /C 12 /M "Select option:"

if errorlevel 2 goto exit
if errorlevel 1 goto again

:exit
echo.
echo Thank you for using this tool!
pause