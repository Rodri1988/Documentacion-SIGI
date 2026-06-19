#!/usr/bin/env bash
# Copia reportes JaCoCo a docs/cobertura para entrega académica
# Uso: ./docs/scripts/copiar-reportes-cobertura.sh
# Requiere haber ejecutado antes: mvn verify

set -e
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DEST="$ROOT/docs/cobertura"
mkdir -p "$DEST"

MODS=(
  servicio-usuario
  servicio-reporte
  servicio-ubicacion
  servicio-emergencia
  servicio-recurso
  servicio-notificacion
  servicio-empleo
  servicio-media
)

for m in "${MODS[@]}"; do
  SRC="$ROOT/$m/target/site/jacoco/index.html"
  if [ -f "$SRC" ]; then
    mkdir -p "$DEST/$m"
    cp "$SRC" "$DEST/$m/index.html"
    echo "Copiado: $m"
  else
    echo "AVISO: no existe $SRC — ejecuta mvn verify primero"
  fi
done

AGG="$ROOT/target/site/jacoco-aggregate/index.html"
if [ -f "$AGG" ]; then
  mkdir -p "$DEST/agregado"
  cp "$AGG" "$DEST/agregado/index.html"
  echo "Copiado: reporte agregado"
fi

echo "Listo. Reportes en docs/cobertura/"
