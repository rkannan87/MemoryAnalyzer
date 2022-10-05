@Echo OFF
setlocal EnableDelayedExpansion
set pid=%1
echo %pid%| findstr /r "^[1-9][0-9]*$">nul

if errorlevel 1 (
    echo Invalid pid
	exit/b
)

set DELAY=%2
echo %DELAY%| findstr /r "^[1-9][0-9]*$">nul
if errorlevel 1 (
    echo Invalid delay
	exit/b
)
echo %DELAY%

set iterations=%3
echo %iterations%| findstr /r "^[1-9][0-9]*$">nul
if errorlevel 1 (
    echo Invalid number of iterations
	exit/b
)

FOR /L %%A in (1,1,%iterations%) do (
    set MM=!DATE:~4,2!
	set DD=!DATE:~7,2!
	set HH=!TIME: =0!
	set HH=!HH:~0,2!
	set MI=!TIME:~3,2!
	set SS=!TIME:~6,2!
	set fileName=hDump_%pid%_!MM!!DD!!HH!!MI!!SS!.hprof
	C:\swdtools\jdk11.0.7-X64\bin\jmap -dump:live,format=b,file=!fileName! %pid%
    REM SLEEP %DELAY%
	TIMEOUT /T %DELAY%
    echo .
)