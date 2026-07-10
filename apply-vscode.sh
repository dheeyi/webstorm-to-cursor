#!/usr/bin/env bash
# apply-vscode.sh — copies the .vscode template (tasks + RN buttons) into a project.
# Usage:  ./apply-vscode.sh [project-path]   (default: current directory)
# Safe: if a file already exists it WON'T overwrite it; leaves a *.from-template copy next to it.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TPL="$REPO_DIR/vscode-template"
TARGET="${1:-$PWD}"
DEST="$TARGET/.vscode"

[ -d "$TARGET" ] || { echo "Directory not found: $TARGET"; exit 1; }
mkdir -p "$DEST"
echo "==> Applying .vscode template to: $TARGET"

for f in tasks.json settings.json; do
  if [ -e "$DEST/$f" ]; then
    cp "$TPL/$f" "$DEST/$f.from-template"
    echo "    [!] $f already exists — left '$f.from-template' for you to merge manually"
  else
    cp "$TPL/$f" "$DEST/$f"
    echo "    [OK] $f copied"
  fi
done

echo "==> Done. Make sure the 'kubrickcode.quick-command-buttons' extension is installed"
echo "    (it's in extensions.txt if you ran install.sh)."
