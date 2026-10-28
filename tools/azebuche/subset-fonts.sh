#!/bin/sh
# Make the small WOFF2 fonts in azebuche/fonts/ from sonomayrit's fonts in src/Fonts/.
# Keeps Latin with accents (Spanish, French, Italian, Catalan, Maltese, Amazigh
# Latin, transliterated Arabic like ū ḥ ṣ) and punctuation.
#
#   sh tools/azebuche/subset-fonts.sh      (needs: pip install fonttools brotli)
set -e
cd "$(dirname "$0")/../.."
for f in SuisseIntl-Light.otf SuisseIntl-Medium.otf NeurealTrial-Mono.otf; do
  python -m fontTools.subset "src/Fonts/$f" \
    --unicodes="U+0020-007E,U+00A0-017F,U+0218-021B,U+1E00-1EFF,U+2010-2027,U+2030-203A,U+20AC,U+2190-2193" \
    --layout-features='kern,liga,tnum,case' --flavor=woff2 \
    --output-file="azebuche/fonts/${f%.*}.woff2"
done
ls -l azebuche/fonts
