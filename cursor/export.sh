#!/usr/bin/env bash
# export.sh — copia la config VIVA de esta Mac HACIA el repo (para "sembrar").
# Corré esto UNA VEZ en tu PC mejor configurada, luego commit + push.
# En el resto de PCs usás install.sh (que crea symlinks; ahí ya no hace falta exportar).
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_DIR="$HOME/Library/Application Support/Cursor/User"

CURSOR_BIN=""
if command -v cursor >/dev/null 2>&1; then
  CURSOR_BIN="cursor"
elif [ -x "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" ]; then
  CURSOR_BIN="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
fi

copy() {
  local src="$1" dst="$2"
  if [ -L "$src" ]; then
    echo "    skip (ya es symlink al repo): $(basename "$src")"
    return
  fi
  if [ -e "$src" ]; then
    cp -R "$src" "$dst"
    echo "    copiado: $(basename "$src")"
  else
    echo "    no existe en esta máquina: $(basename "$src")"
  fi
}

echo "==> Exportando config de esta Mac al repo"
copy "$USER_DIR/settings.json"    "$REPO_DIR/settings.json"
copy "$USER_DIR/keybindings.json" "$REPO_DIR/keybindings.json"
if [ -d "$USER_DIR/snippets" ] && [ ! -L "$USER_DIR/snippets" ]; then
  rm -rf "$REPO_DIR/snippets"
  cp -R "$USER_DIR/snippets" "$REPO_DIR/snippets"
  echo "    copiado: snippets/"
fi

echo "==> Regenerando extensions.txt"
if [ -n "$CURSOR_BIN" ]; then
  {
    echo "# Extensiones de Cursor — regenerado por export.sh ($(date +%Y-%m-%d))"
    "$CURSOR_BIN" --list-extensions
  } > "$REPO_DIR/extensions.txt"
  echo "    ok ($("$CURSOR_BIN" --list-extensions | wc -l | tr -d ' ') extensiones)"
else
  echo "    (!) CLI 'cursor' no encontrado; extensions.txt sin cambios."
fi

echo "==> Listo. Ahora: git add -A && git commit -m 'seed cursor config' && git push"
