# AGENTS.md

Guidance for AI agents working in this dotfiles repo.

## Layout

- `dotfiles/` — canonical config sources, organized per app
- `dotfiles/mango/` — compositor config (`config.conf`, `keybind.conf`) + `mango-portals.conf`
- `dotfiles/niri/` — **archived**, do not edit or "modernize" (see `DEPRECATED.md`)
- `dotfiles/waybar|fuzzel|mako|waypaper/` — legacy reference only; replaced by Noctalia shell
- `FEDORA_SETUP.md` — full machine rebuild guide

## Live configs are symlinks into this repo

`~/.config/{alacritty,btop,zed,obsidian,mango}` are **directory symlinks** to
`dotfiles/<app>`, and `~/.config/{hyfetch.json,mimeapps.list}` are file symlinks.
Editing `dotfiles/<app>/...` edits the live config directly — no copy step.

Caveats:
- **Directory** symlinks survive apps that save atomically (write temp file +
  rename): the replaced file lands inside the repo target dir.
- **File** symlinks (`hyfetch.json`, `mimeapps.list`) can be silently replaced
  by a real file when an app atomically rewrites them (e.g. `xdg-mime`).
  If a link disappears, restore it: `ln -sf ~/dots/dotfiles/<file> ~/.config/<file>`.
- `~/.config/xdg-desktop-portal/mango-portals.conf` is a plain copy, not linked.
- The Slick desktop entry is installed system-wide in `/usr/share/applications`;
  `dotfiles/applications/` is reference only.

## Mango specifics

- Config hot-reloads on save — no restart needed to apply changes
- Validate before/after edits: `mango -c ~/.config/mango/config.conf -p`
- Noctalia IPC binds must follow the Noctalia guide
  (https://docs.noctalia.dev/noctalia/compositor-settings/mango/):
  `layer_animations=0`, `blur_layer=0`, `layer_shadows=0` — mango's compositor
  layer effects conflict with Noctalia's own surface effects
- Default layout is `scroller` via `tag_rule=id:*,layout_name:scroller`
  (chosen to match niri's scrollable columns, which this setup replaced)
- `quit` has no confirmation dialog

## Machine-level context (not in this repo)

- `~/.config/logbook.md` — chronological record of all config changes; append an
  entry for any significant change
- `~/.config/agents.md` — machine context and standing warnings (PipeWire
  `context.modules` trap, WiFi/BT configs that must not be reverted)

## Git

- Remote: `https://github.com/Baustinlynch/dots.git` (branch `main`)
- Identity is repo-local (`brenden <brenden@brenden.zip>`); global gitconfig has none
- `gh` CLI is authenticated; commits are pushed directly, no PR flow
