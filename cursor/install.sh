#!/usr/bin/env bash
# install.sh — aplica la config del repo A ESTA Mac.
#   - Crea symlinks: settings.json, keybindings.json, snippets/ -> repo
#   - Reinstala las extensiones listadas en extensions.txt
# Idempotente: se puede correr las veces que quieras.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_DIR="$HOME/Library/Application Support/Cursor/User"

# Localizar el CLI de Cursor (PATH o dentro del .app)
CURSOR_BIN=""
if command -v cursor >/dev/null 2>&1; then
  CURSOR_BIN="cursor"
elif [ -x "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" ]; then
  CURSOR_BIN="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
fi

echo "==> Repo:  $REPO_DIR"
echo "==> User:  $USER_DIR"
mkdir -p "$USER_DIR"

link() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "    backup: $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "    link:   $dst -> $src"
}

echo "==> Symlinks de config"
link "$REPO_DIR/settings.json"    "$USER_DIR/settings.json"
link "$REPO_DIR/keybindings.json" "$USER_DIR/keybindings.json"
link "$REPO_DIR/snippets"         "$USER_DIR/snippets"

echo "==> Extensiones"
if [ -z "$CURSOR_BIN" ]; then
  echo "    (!) No encontré el CLI 'cursor'. En Cursor: Cmd+Shift+P ->"
  echo "        'Shell Command: Install cursor command in PATH', luego re-corré este script."
else
  grep -vE '^\s*#|^\s*$' "$REPO_DIR/extensions.txt" | while read -r ext; do
    echo "    install: $ext"
    "$CURSOR_BIN" --install-extension "$ext" --force >/dev/null 2>&1 \
      && echo "      ok" || echo "      (falló, revisar id)"
  done
fi

echo "==> Listo. Reiniciá Cursor para que tome todo."
