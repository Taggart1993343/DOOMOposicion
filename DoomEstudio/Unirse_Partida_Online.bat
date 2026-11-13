@echo off
cd /d "%~dp0"
title DOOM Estudio - Unirse a partida online
if not exist "GZDOOM\gzdoom.exe" (
  echo Falta GZDoom: copia gzdoom.exe y el resto de sus archivos en la carpeta GZDOOM.
  echo Se descarga gratis de https://zdoom.org/downloads
  pause
  exit /b
)
if not exist "WAD\DOOM.WAD" (
  echo Falta DOOM.WAD: copia tu DOOM.WAD de The Ultimate Doom en la carpeta WAD.
  pause
  exit /b
)
call "Temarios\elegir_temario.bat"
rem Super escopeta de DOOM II (opcional): la crea herramientas\crear_superescopeta.py desde tu DOOM2.WAD.
rem Sin ella se empieza con la escopeta normal.
set "SSG="
if exist "Mod\SuperEscopeta_DOOM2.pk3" set SSG="Mod\SuperEscopeta_DOOM2.pk3"
rem Brutal Doom: el primer .pk3 que haya en la carpeta BrutalDOOM
set "BD="
for %%F in ("BrutalDOOM\*.pk3") do if not defined BD set BD="%%~fF"
echo Todos los jugadores tienen que usar el MISMO temario.
echo.
echo ================================================
echo   DOOM ESTUDIO - UNIRSE A PARTIDA COOPERATIVA
echo ================================================
echo.
echo Usa lo mismo que el anfitrion (con o sin Brutal Doom).
echo El mapa lo elige el anfitrion: entraras en el suyo.
echo.
set /p IP=IP del anfitrion: 
set /p B=Con Brutal Doom? (s/n): 
echo.
echo Conectando con %IP% ...
if /i "%B%"=="s" goto :brutal
start "" "GZDOOM\gzdoom.exe" -iwad "WAD\DOOM.WAD" -file %SSG% "Mod\DoomEstudio.pk3" %TFILE% -join %IP% -exec "Controles\controles_normal.cfg"
goto :eof
:brutal
if not defined BD (
  echo Falta Brutal Doom: pon su archivo .pk3 en la carpeta BrutalDOOM.
  pause
  exit /b
)
start "" "GZDOOM\gzdoom.exe" -iwad "WAD\DOOM.WAD" -file %BD% "Mod\DoomEstudio.pk3" %TFILE% -join %IP% -exec "Controles\controles_brutal.cfg"
