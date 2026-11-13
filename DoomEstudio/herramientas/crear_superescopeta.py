# Crea SuperEscopeta_DOOM2.pk3 con los graficos y sonidos de la super escopeta,
# sacados de TU DOOM2.WAD (carpeta WAD). Hace falta para jugar con la super
# escopeta en DOOM 1 normal (Jugar.bat). Brutal Doom ya trae la suya.
# Sin este archivo el juego funciona igual, pero se empieza con la escopeta normal.
# Uso: python herramientas\crear_superescopeta.py   (desde la carpeta del juego)
import os, re, struct, sys, zipfile

base = os.path.dirname(os.path.abspath(__file__))
juego = base if os.path.isdir(os.path.join(base, "WAD")) else os.path.dirname(base)
wad = os.path.join(juego, "WAD", "DOOM2.WAD")
salida = os.path.join(juego, "Mod", "SuperEscopeta_DOOM2.pk3")

if not os.path.isfile(wad):
    sys.exit("No encuentro " + wad)
d = open(wad, "rb").read()
tipo, n, off = struct.unpack("<4sii", d[:12])
lumps = {}
for i in range(n):
    pos, size, name = struct.unpack("<ii8s", d[off + 16 * i: off + 16 * i + 16])
    lumps[name.rstrip(b"\0").decode("ascii", "replace").upper()] = d[pos:pos + size]

sprites = sorted(k for k in lumps if re.match(r"^(SHT2[A-Z]0|SGN2A0)$", k))
sonidos = [k for k in ("DSDSHTGN", "DSDBOPN", "DSDBCLS", "DSDBLOAD") if k in lumps]
if len(sprites) < 5 or len(sonidos) < 4:
    sys.exit("Este DOOM2.WAD no tiene la super escopeta completa")
with zipfile.ZipFile(salida, "w", zipfile.ZIP_DEFLATED) as z:
    for k in sprites:
        z.writestr("sprites/" + k + ".lmp", lumps[k])
    for k in sonidos:
        z.writestr("sounds/" + k + ".lmp", lumps[k])
print("Creado %s (%d graficos, %d sonidos)" % (salida, len(sprites), len(sonidos)))
