#!/usr/bin/env bash
# Convierte informes Markdown a PDF (pandoc + Chrome headless).
set -euo pipefail

DOCS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ROOT_DIR="$(cd "$DOCS_DIR/.." && pwd)"
PANDOC="${PANDOC:-/tmp/pandoc-3.6.4-x86_64/bin/pandoc}"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
PDF_DIR="$DOCS_DIR/pdf"
TMP_DIR="$(mktemp -d)"

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

if [[ ! -x "$PANDOC" ]]; then
  echo "No se encontró pandoc en $PANDOC" >&2
  exit 1
fi
if [[ ! -x "$CHROME" ]]; then
  echo "No se encontró Google Chrome en $CHROME" >&2
  exit 1
fi

mkdir -p "$PDF_DIR"

preprocess() {
  local src="$1"
  local base processed
  base="$(basename "$src" .md)"
  processed="$TMP_DIR/${base}.md"

  python3 - "$src" "$base" "$processed" <<'PY'
import re, sys
from pathlib import Path

src, base, out = sys.argv[1], sys.argv[2], sys.argv[3]
text = Path(src).read_text(encoding="utf-8")

if base == "INFORME_PRUEBAS_UNITARIAS":
    chart = """
<div class="coverage-chart">
  <p><strong>Cobertura de líneas por microservicio (%)</strong></p>
  <div class="bar-row"><span>Usuario</span><div class="bar" style="width:91.9%"></div><span>91,9%</span></div>
  <div class="bar-row"><span>Reporte</span><div class="bar" style="width:92%"></div><span>92,0%</span></div>
  <div class="bar-row"><span>Ubicación</span><div class="bar" style="width:86.9%"></div><span>86,9%</span></div>
  <div class="bar-row"><span>Emergencia</span><div class="bar" style="width:97.9%"></div><span>97,9%</span></div>
  <div class="bar-row"><span>Recurso</span><div class="bar" style="width:98.5%"></div><span>98,5%</span></div>
  <div class="bar-row"><span>Notificación</span><div class="bar" style="width:89.6%"></div><span>89,6%</span></div>
  <div class="bar-row"><span>Empleo</span><div class="bar" style="width:85.4%"></div><span>85,4%</span></div>
  <div class="bar-row"><span>Media</span><div class="bar" style="width:98%"></div><span>98,0%</span></div>
  <div class="threshold">Umbral mínimo exigido: 70%</div>
</div>
"""
    text = re.sub(r"```mermaid[\s\S]*?```", chart, text, count=1)

if base == "ARQUITECTURA_MICROSERVICIOS":
    img = "diagramas/arquitectura-microservicios-sigi.png"
    replacement = f"\n![Diagrama de arquitectura]({img})\n"
    text = re.sub(r"```mermaid[\s\S]*?```", replacement, text, count=1)

Path(out).write_text(text, encoding="utf-8")
PY

  echo "$processed"
}

convert_one() {
  local src="$1"
  local name processed html pdf workdir
  name="$(basename "$src" .md)"
  workdir="$(dirname "$src")"
  processed="$(preprocess "$src")"
  html="$TMP_DIR/${name}.html"
  pdf="$PDF_DIR/${name}.pdf"

  "$PANDOC" "$processed" \
    --from markdown \
    --to html5 \
    --standalone \
    --embed-resources \
    --metadata title="$name" \
    --resource-path="$workdir:$DOCS_DIR" \
    --css "$DOCS_DIR/scripts/pdf-styles.css" \
    -o "$html"

  "$CHROME" \
    --headless=new \
    --disable-gpu \
    --no-pdf-header-footer \
    --print-to-pdf="$pdf" \
    "file://${html}"

  echo "OK  $pdf"
}

for md in "$DOCS_DIR"/*.md; do
  [[ -f "$md" ]] || continue
  convert_one "$md"
done

for md in "$ROOT_DIR"/INFORME_*.md; do
  [[ -f "$md" ]] || continue
  convert_one "$md"
done

echo ""
echo "PDFs generados en: $PDF_DIR"
