# webstorm-to-cursor

> Make **Cursor** feel like **WebStorm** — keybindings, theme, git blame, collapsible diffs,
> run buttons — and keep it in sync across your Macs. macOS-focused.

Cursor has **no built-in settings sync** (it doesn't use Microsoft's Settings Sync server), so
this is a tiny dotfiles setup that does two things:

1. **Syncs** your Cursor config across machines via symlinks (edit in Cursor → it's in the repo → `git push` → `git pull` elsewhere).
2. Ships an **opinionated, WebStorm-like setup** you can install in a couple of minutes.

Coming from JetBrains? You'll feel at home without giving up Cursor's AI.

## What you get

- **WebStorm/IntelliJ keybindings** (via the IntelliJ Keybindings extension) + custom binds:
  toggle terminal, fold/unfold, find next/prev, search-result nav, **git blame** (WebStorm "Annotate").
- **WebStorm New UI theme** + **JetBrains Mono** font + **Material icons**.
- **Prettier + ESLint format-on-save** (WebStorm's "Actions on Save").
- **Collapsible unchanged regions** in diffs (WebStorm's "Collapse unchanged fragments").
- **Type-to-search** in trees, permanent tabs, **auto-update imports** on file move.
- **Git blame gutter** via GitLens; **Git Graph** for visual history.
- **Per-project tasks + status-bar run buttons** (WebStorm's "External Tools / Run Configurations").
- A **WebStorm → Cursor keyboard cheat-sheet**: [`docs/cursor-webstorm-keymap.md`](./docs/cursor-webstorm-keymap.md).

## Requirements

macOS · [Cursor](https://cursor.com) · [Homebrew](https://brew.sh) (for the font) · the `cursor`
CLI on your `PATH` (in Cursor: `Cmd+Shift+P` → *"Shell Command: Install cursor command in PATH"*).

## Quick start

```bash
git clone https://github.com/dheeyi/webstorm-to-cursor.git ~/dotfiles
cd ~/dotfiles

brew install --cask font-jetbrains-mono   # the font
./cursor/install.sh                        # symlink config + install extensions

# Per project (tasks + run buttons). The template targets React Native — adapt for your stack:
./apply-vscode.sh /path/to/your/project
```

Restart Cursor and you're done.

> `install.sh` backs up any existing config to `*.bak` before symlinking — nothing is lost.

## What's inside

```
.
├── cursor/                       # global Cursor config (symlinked to ~/Library/.../Cursor/User)
│   ├── settings.json             # theme, font, format-on-save, WebStorm-like behavior
│   ├── keybindings.json          # custom binds on top of the IntelliJ keymap
│   ├── extensions.txt            # extensions to install (one id per line)
│   ├── install.sh                # symlinks config + installs extensions
│   └── export.sh                 # seed the repo from a machine's live config
├── vscode-template/              # per-project .vscode (tasks + run buttons) — React Native example
├── apply-vscode.sh               # copy the template into any project (won't overwrite)
└── docs/
    └── cursor-webstorm-keymap.md # WebStorm → Cursor keyboard cheat-sheet
```

`state.vscdb` (Cursor's per-machine SQLite state) is intentionally **not** synced.

## Customize

- **Theme** — set `workbench.colorTheme` in `cursor/settings.json`. The WebStorm theme ships several
  variants: `WebStorm New Darcula`, `WebStorm Darker`, `WebStorm Dark`, `WebStorm Light`.
- **Extensions** — add/remove ids in `cursor/extensions.txt`, then re-run `install.sh`.
- **Keybindings** — `cursor/keybindings.json`.

### Change the run commands (tasks + buttons)

The run buttons and tasks just mirror the scripts in each project. To change them:

1. Open the project's tasks file: `Cmd+Shift+P` → **"Tasks: Open User Tasks"**, or just open
   `.vscode/tasks.json` in the file tree.
2. Edit the `command` of a task (e.g. change `npm run ios` to `yarn ios`), or add a new one:
   ```jsonc
   { "label": "Storybook", "type": "shell", "command": "npm run storybook" }
   ```
3. Save. Run it with `Cmd+Shift+P` → **"Tasks: Run Task"**.

To change the **status-bar buttons**, edit `quickCommandButtons.buttons` in `.vscode/settings.json`
(name, `command`, `color`, `shortcut`). The defaults live in `vscode-template/` — edit there to
change the starting point for every new project, then apply with `./apply-vscode.sh <project>`.

## Keyboard shortcuts (macOS)

WebStorm/IntelliJ keymap (via the IntelliJ Keybindings extension) plus the custom binds this repo
adds. A few highlights below — the **full reference** (editing, refactor, search, custom binds, AI,
and the Search Everywhere prefixes) lives in
**[docs/cursor-webstorm-keymap.md](./docs/cursor-webstorm-keymap.md)**.

Legend: `Cmd` ⌘ · `Opt` ⌥ · `Shift` ⇧ · `Ctrl` ⌃

| Action | Shortcut |
|---|---|
| Search Everywhere (files + content + symbols) | `Shift` `Shift` |
| Find Action / command palette | `Cmd+Shift+A` / `Cmd+Shift+P` |
| Go to definition / implementation | `Cmd+B` / `Opt+Cmd+B` |
| Reformat code (also on save) | `Cmd+Opt+L` |
| Quick fix / intentions | `Opt+Enter` |
| Rename | `Shift+F6` |
| Git blame whole file (≈ Annotate) | `Cmd+Shift+B` |
| Toggle terminal | `Opt+F12` |

→ **[Open the full cheat-sheet](./docs/cursor-webstorm-keymap.md)** for every shortcut.

## Sync across machines

1. Edit settings/keybindings in Cursor (they're symlinks, so the repo changes).
2. `git add -A && git commit -m "..." && git push`
3. On the other Mac: `git pull` (restart Cursor if you touched extensions/theme).

## What Cursor can't replicate (honest limits)

Cursor is a VS Code fork, so a few WebStorm things have no equivalent — no setup fixes these:

- **Search Everywhere for actions/settings** (code search *is* unified via double-`Shift`; actions live in the Command Palette `>`).
- **Deep JetBrains refactors** (basic rename/extract are covered).
- **WebStorm's exact window structure** (toolbars, tool windows).

## Credits

Built on these extensions — thanks to their authors:
`k--kato.intellij-idea-keybindings` · `SeptWong.vscode-webstorm-theme` · `PKief.material-icon-theme` ·
`esbenp.prettier-vscode` · `dbaeumer.vscode-eslint` · `eamodio.gitlens` · `mhutchie.git-graph` ·
`usernamehw.errorlens` · `Gruntfuggly.todo-tree` · `KubrickCode.quick-command-buttons`.

## Contributing

macOS-focused for now. PRs adding Windows/Linux paths (config lives in `%APPDATA%\Cursor\User`
and `~/.config/Cursor/User`) are very welcome.

## License

[MIT](./LICENSE).
