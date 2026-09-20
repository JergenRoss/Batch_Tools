@ECHO OFF

::  enable to no reduce
:_enable
    ECHO Regedit set to Indexing-Fast
    Regedit /S  Indexing-Fast.reg
    SET "_var=fast"
GOTO :_resetservice

:: disable or revert
:_disable
    ECHO Regedit set to Indexing-Normal
    Regedit /S  Indexing-Normal.reg
    SET "_var=normal"
GOTO :_resetservice

::  Open Control Panel - Indexing Options
:_RUN
    Echo Open Control Panel - Indexing Options
    Echo Wait for completed, then continue 
    start "" /wait /b "control" /name Microsoft.IndexingOptions
    pause
    GOTO :_disable

::  reset service
:_resetservice
    FOR /L %%1 IN (1,1,2) DO (
        Net Stop Wsearch
    )
    Net Start Wsearch
    IF "%_var%" == "fast" GOTO :_RUN
    IF "%_var%" == "normal" GOTO :_DEFRAG

:: Defragment the index database
:_DEFRAG
    timeout 5
    ECHO Defragment the index database
    Sc config wsearch start=disabled
    Net stop wsearch
    EsentUtl.exe /d %AllUsersProfile%\Microsoft\Search\Data\Applications\Windows\Windows.edb
    Sc config wsearch start=delayed-auto
    Net start wsearch
    pause
:_END