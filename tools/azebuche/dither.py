# tools/azebuche/dither.py  —  python dither.py src/azebuche/raw src/azebuche/dithered
# Turns each photo into an 800x600 1-bit PNG (Floyd–Steinberg), white transparent.
# Runs automatically on every build (_plugins/azebuche.rb); only new or changed photos are processed.
import sys, pathlib
from PIL import Image, ImageOps
src, dst = map(pathlib.Path, sys.argv[1:3]); dst.mkdir(parents=True, exist_ok=True)
for f in sorted(src.iterdir()):
    if f.suffix.lower() not in {".jpg", ".jpeg", ".png", ".webp"}: continue
    out = dst / (f.stem + ".png")
    if out.exists() and out.stat().st_mtime >= f.stat().st_mtime: continue
    im = ImageOps.exif_transpose(Image.open(f)).convert("L")
    im = ImageOps.fit(im, (800, 600)); im = ImageOps.autocontrast(im, cutoff=1)
    bw = im.convert("1")  # Floyd–Steinberg
    p = Image.new("P", im.size); p.putpalette([0,0,0, 255,255,255] + [0]*762)
    p.paste(bw.convert("L").point(lambda v: 1 if v else 0))
    p.save(out, optimize=True, transparency=1)
    print(out, out.stat().st_size // 1024, "KB")
