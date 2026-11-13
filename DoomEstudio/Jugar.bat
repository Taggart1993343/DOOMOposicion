@echo off
cd /d "%~dp0"
rem DOOM normal + modo estudio. R = recargar con pregunta
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
rem Mapa inicial al azar: episodios 1-4, mapas 1-7 (sin los jefes del mapa 8 ni los secretos).
rem El primer numero al azar de Windows casi no cambia de una vez a otra, asi que se descarta.
set /a R=%RANDOM%
set /a EP=%RANDOM% %% 4 + 1
set /a MP=%RANDOM% %% 7 + 1
start "" "GZDOOM\gzdoom.exe" -iwad "WAD\DOOM.WAD" -file %SSG% "Mod\DoomEstudio.pk3" %TFILE% -warp %EP% %MP% -exec "Controles\controles_normal.cfg"
