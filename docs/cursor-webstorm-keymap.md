# Cursor as WebStorm — shortcuts & commands (macOS)

A reference for driving **Cursor** with **WebStorm / IntelliJ** muscle memory. The "WebStorm-style"
shortcuts come from the **`k--kato.intellij-idea-keybindings`** extension; most work identically,
but **some may differ or not fire** (Cursor is a VS Code fork — not every JetBrains action exists).
If one doesn't respond, see [Verify / rebind](#verify--rebind) at the end.

> Config lives in `cursor/settings.json` and `cursor/keybindings.json` and syncs across machines
> via symlinks — editing in Cursor edits the repo.

Legend: `Cmd` ⌘ · `Opt/Alt` ⌥ · `Shift` ⇧ · `Ctrl` ⌃

---

## Search & navigation (WebStorm's strong suit)

| Action | Shortcut | Notes |
|---|---|---|
| **Search Everywhere** | `Shift` `Shift` (double) | Searches files + content + symbols in one box |
| Find Action / command | `Cmd+Shift+A` | Equivalent to the Command Palette (`Cmd+Shift+P`) |
| Go to file | `Cmd+Shift+O` | |
| Go to class / symbol | `Cmd+O` | |
| Go to symbol in project | `Opt+Cmd+O` | |
| Recent files | `Cmd+E` | |
| Go to declaration / definition | `Cmd+B` or `Cmd+Click` | |
| Go to implementation | `Opt+Cmd+B` | |
| Find usages | `Opt+F7` | |
| Find in files | `Cmd+Shift+F` | |
| Replace in files | `Cmd+Shift+R` | |
| Go to line | `Cmd+L` | |
| Back / Forward (navigation) | `Cmd+[` / `Cmd+]` | |
| Toggle project panel | `Cmd+1` | |
| Next / previous error | `F2` / `Shift+F2` | |

### Search Everywhere in detail (double `Shift`)

Open with **double `Shift`** and search files + content + symbols in one box. A **prefix**
narrows the search:

| Prefix | Searches | Example | Result |
|---|---|---|---|
| _(none)_ | Files, content, symbols | `Card` | Shows `Card/index.tsx`, `Card.test.tsx`, and usages of `Card` |
| `:` | Line in the current file | `:42` | Jumps to line 42 |
| `@` | Symbol in the **current file** | `@render` | Goes to the `render` function/method |
| `#` | Symbol in the **whole workspace** | `#useStructureCapture` | Finds the hook anywhere in the project |
| `>` | Command (≈ WebStorm's Find Action) | `>format` | Runs "Format Document" |

> Tip: combine file + line as `file:line`, e.g. `index:15` opens `index.tsx` at line 15.

## Editing

| Action | Shortcut | Notes |
|---|---|---|
| Duplicate line | `Cmd+D` | |
| Delete line | `Cmd+Backspace` | |
| Move line up / down | `Opt+Shift+↑` / `↓` | |
| Toggle line comment | `Cmd+/` | |
| Toggle block comment | `Cmd+Shift+/` | |
| **Reformat code** | `Cmd+Opt+L` | Also runs on save (Prettier) |
| Optimize / organize imports | `Ctrl+Opt+O` | Also runs on save |
| Trigger completion | `Ctrl+Space` | |
| **Quick fix / intentions** | `Opt+Enter` | WebStorm's lightbulb |
| Extend / shrink selection | `Ctrl+W` / `Ctrl+Shift+W` | |
| Select next occurrence | `Ctrl+G` | Incremental multi-cursor |
| Manual multi-cursor | `Opt+Click` | |
| Live templates / snippets | `Cmd+J` | |
| Surround with (tag/block) | `Cmd+Opt+T` | |
| Quick doc | `F1` | |

## Refactor

| Action | Shortcut |
|---|---|
| Rename | `Shift+F6` |
| Refactor this (menu) | `Ctrl+T` |
| Extract variable | `Cmd+Opt+V` |
| Extract constant | `Cmd+Opt+C` |
| Extract method / function | `Cmd+Opt+M` |
| Move | `F6` |

## Run / tools

| Action | Shortcut | Notes |
|---|---|---|
| Run Anything | `Ctrl` `Ctrl` (double) | May not map identically in Cursor |
| Run / Debug | `Ctrl+R` / `Ctrl+D` | Depends on run configs |
| Settings | `Cmd+,` | |
| Open keymap | `Cmd+K Cmd+S` | Native to Cursor |

---

## Custom binds added on top of the extension

Defined in `cursor/keybindings.json`:

| Action | Shortcut |
|---|---|
| Toggle terminal | `Opt+F12` |
| Fold / unfold the whole file | `Cmd+Shift+-` / `Cmd+Shift+=` |
| Fold / unfold recursively (from cursor) | `Cmd+Opt+-` / `Cmd+Opt+=` |
| Find next / previous match | `F3` / `Shift+F3` |
| Navigate search-panel results | `F4` / `Shift+F4` |
| **Git blame the whole file** (≈ WebStorm Annotate) | `Cmd+Shift+B` |
| **Type-to-search** in the tree | Just start typing with the explorer focused |
| **Format on save** (Prettier + ESLint fix) | Automatic, no shortcut |
| Copy relative path (≈ Copy Reference) | Right-click → *Copy Relative Path* |

---

## What Cursor does better / differently (AI bonus)

WebStorm has none of this — use it:

| Action | Shortcut |
|---|---|
| Inline edit/generate (prompt) | `Cmd+K` |
| Open AI chat | `Cmd+L` |
| Agent / Composer | `Cmd+I` |
| Accept AI suggestion (autocomplete) | `Tab` |
| Command Palette (everything) | `Cmd+Shift+P` |

---

## What does NOT exist in Cursor (honest limits vs WebStorm)

No shortcut fixes these — it's an engine difference:

- **Actions/Settings inside Search Everywhere**: Cursor unifies files + content + symbols under
  double-`Shift`, but *actions and settings* live separately in the Command Palette (`>`).
- **Deep JetBrains refactors** (basic ones are covered above).
- **WebStorm's exact window structure** (toolbars, tool windows).

---

## Verify / rebind

1. `Cmd+Shift+P` → **"Preferences: Open Keyboard Shortcuts"** to view/search any binding.
2. If a WebStorm shortcut doesn't fire, it's usually a **conflict**: find the action there and
   reassign it, or edit `cursor/keybindings.json` (it syncs to your other Macs).
3. To change behavior (formatting, autosave, etc.): `cursor/settings.json`.

> Honest note: this table reflects WebStorm's macOS keymap. In Cursor the IntelliJ extension
> covers the vast majority, but not 100% — verify the ones you use most.
