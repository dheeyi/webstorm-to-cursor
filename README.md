# dotfiles

Sincronización de configuración de **Cursor** entre varias Macs, sin backups manuales.
El repo es la **fuente de verdad**: en cada máquina la config vive como *symlink* al repo,
así que editás en Cursor → se edita el archivo del repo → `git push` → en las otras `git pull`.

## Qué se sincroniza
- `cursor/settings.json` — tema, fuentes, autosave (look estilo WebStorm)
- `cursor/keybindings.json` — tus overrides de atajos
- `cursor/snippets/` — snippets propios
- `cursor/extensions.txt` — lista de extensiones (se reinstalan, no se versiona el binario)

No se sincroniza `state.vscdb` (SQLite de estado por-máquina) a propósito.

## Primer arranque (una sola vez, en tu PC MEJOR configurada)
```bash
cd ~/dotfiles/cursor
./export.sh                 # copia tu config viva al repo + genera extensions.txt
cd ~/dotfiles
git add -A && git commit -m "seed cursor config" && git push
```

## En cada PC nueva
```bash
git clone <tu-repo> ~/dotfiles
cd ~/dotfiles/cursor
./install.sh                # symlinks repo -> máquina + reinstala extensiones
```
> Si `install.sh` avisa que falta el CLI `cursor`: en Cursor abrí `Cmd+Shift+P`
> → *"Shell Command: Install cursor command in PATH"*, y re-corré el script.

## Flujo diario
1. Editás settings/atajos en Cursor (como es symlink, cambia el archivo del repo).
2. `cd ~/dotfiles && git add -A && git commit -m "..." && git push`
3. En las otras Macs: `git pull` (y reiniciar Cursor si tocaste extensiones/tema).

## Look estilo WebStorm (Darcula)
- Instalá la fuente **JetBrains Mono** (ya referenciada en `settings.json`).
- Para el tema Darcula real, instalá un tema JetBrains del marketplace y poné su nombre
  en `workbench.colorTheme` dentro de `settings.json`.
- Los atajos los da la extensión `k--kato.intellij-idea-keybindings` (en `extensions.txt`).
