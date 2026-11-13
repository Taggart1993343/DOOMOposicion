@echo off
rem Elige el temario que se carga junto al mod (Mod\DoomEstudio.pk3). Lo usan los .bat de jugar.
rem Un temario es una carpeta (o un .pk3) dentro de Temarios con estudio\preguntas.txt.
rem Las carpetas que empiezan por _ no salen en la lista (la plantilla).
rem Si solo hay uno, se usa ese. Si hay varios, pregunta (Enter = el de la ultima vez).
rem Deja en TFILE la ruta entre comillas para -file (vacio si no hay ninguno).
set "TEMARIO="
set "TFILE="
set /a NT=0
pushd "%~dp0"
for /d %%D in (*) do call :anadir "%%~nxD" "%%~fD"
for %%F in (*.pk3) do call :anadir "%%~nxF" "%%~fF"
popd
if %NT%==0 goto :ninguno
if %NT%==1 goto :uno
set "ULT=1"
if exist "%~dp0ultimo.txt" set /p ULT=<"%~dp0ultimo.txt"
echo.
echo Temarios:
for /l %%i in (1,1,%NT%) do call echo   %%i. %%TNOM%%i%%
set "ELIGE="
set /p ELIGE=Cual quieres (Enter = %ULT%)? 
if "%ELIGE%"=="" set "ELIGE=%ULT%"
set /a ELIGE=%ELIGE%+0
if %ELIGE% LSS 1 set ELIGE=1
if %ELIGE% GTR %NT% set ELIGE=1
call set "TEMARIO=%%TRUTA%ELIGE%%%"
set TFILE="%TEMARIO%"
call echo Temario: %%TNOM%ELIGE%%%
>"%~dp0ultimo.txt" echo %ELIGE%
goto :eof

:ninguno
echo No hay ningun temario en la carpeta Temarios: solo saldra una pregunta de aviso.
goto :eof

:uno
set "TEMARIO=%TRUTA1%"
set TFILE="%TRUTA1%"
echo Temario: %TNOM1%
goto :eof

:anadir
set "NOM=%~1"
if "%NOM:~0,1%"=="_" goto :eof
set /a NT+=1
set "TNOM%NT%=%~1"
set "TRUTA%NT%=%~2"
goto :eof
