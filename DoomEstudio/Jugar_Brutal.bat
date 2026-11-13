@echo off
cd /d "%~dp0"
rem BRUTAL DOOM + modo estudio. R = recarga de Brutal Doom, Y = recargar con pregunta
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
rem Brutal Doom: el primer .pk3 que haya en la carpeta BrutalDOOM
set "BD="
for %%F in ("BrutalDOOM\*.pk3") do if not defined BD set BD="%%~fF"
if not defined BD (
  echo Falta Brutal Doom: pon su archivo .pk3 en la carpeta BrutalDOOM.
  pause
  exit /b
)
call "Temarios\elegir_temario.bat"
rem Mapa inicial al azar: episodios 1-4, mapas 1-7 (sin los jefes del mapa 8 ni los secretos).
rem El primer numero al azar de Windows casi no cambia de una vez a otra, asi que se descarta.
set /a R=%RANDOM%
set /a EP=%RANDOM% %% 4 + 1
set /a MP=%RANDOM% %% 7 + 1
start "" "GZDOOM\gzdoom.exe" -iwad "WAD\DOOM.WAD" -file %BD% "Mod\DoomEstudio.pk3" %TFILE% -warp %EP% %MP% -exec "Controles\controles_brutal.cfg"
