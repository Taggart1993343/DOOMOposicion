@echo off
cd /d "%~dp0"
title DOOM Estudio - Crear partida online
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
echo   DOOM ESTUDIO - CREAR PARTIDA COOPERATIVA
echo ================================================
echo.
echo Tus amigos tienen que conectarse a TU IP (la de Radmin VPN / ZeroTier,
echo o tu IP publica si has abierto el puerto UDP 5029 en el router).
echo.
set /p N=Cuantos jugadores en total, contandote a ti (2-8)? 
set /p B=Con Brutal Doom? (s/n): 
echo.
rem Mapa inicial al azar: episodios 1-4, mapas 1-7 (sin los jefes del mapa 8 ni los secretos).
rem El primer numero al azar de Windows casi no cambia de una vez a otra, asi que se descarta.
set /a R=%RANDOM%
set /a EP=%RANDOM% %% 4 + 1
set /a MP=%RANDOM% %% 7 + 1
echo Mapa de esta partida: E%EP%M%MP% (los que se unan entran en el mismo).
echo.
echo Esperando a que se unan los demas...
if /i "%B%"=="s" goto :brutal
start "" "GZDOOM\gzdoom.exe" -iwad "WAD\DOOM.WAD" -file %SSG% "Mod\DoomEstudio.pk3" %TFILE% -host %N% -warp %EP% %MP% -exec "Controles\controles_normal.cfg"
goto :eof
:brutal
if not defined BD (
  echo Falta Brutal Doom: pon su archivo .pk3 en la carpeta BrutalDOOM.
  pause
  exit /b
)
start "" "GZDOOM\gzdoom.exe" -iwad "WAD\DOOM.WAD" -file %BD% "Mod\DoomEstudio.pk3" %TFILE% -host %N% -warp %EP% %MP% -exec "Controles\controles_brutal.cfg"
