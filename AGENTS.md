# AGENTS.md

Guidance for AI agents working in this dotfiles repo.

## Layout

- `dotfiles/` — canonical config sources, organized per app
- `dotfiles/mango/` — compositor config (`config.conf`, `keybind.conf`) + `mango-portals.conf`
- `dotfiles/noctalia/` — `shared.toml` + `machines/*.toml` overlays + `settings.toml` (GUI-managed settings, symlinked live at `~/.local/state/noctalia/settings.toml`; wins over the TOML overlays)
- `dotfiles/fish/` — shell config (`config.fish`, `conf.d/`, `completions/`); `fish_variables` is gitignored machine state
- `dotfiles/niri/` — **archived**, do not edit or "modernize" (see `DEPRECATED.md`)
- `dotfiles/waybar|fuzzel|mako|waypaper/` — legacy reference only; replaced by Noctalia shell
- `FEDORA_SETUP.md` — full machine rebuild guide

## Machine variants

Machine-specific settings live in `machines/` overlays selected by a symlink
(`dotfiles/mango/machine.conf` and `dotfiles/alacritty/machine.toml` are
gitignored symlinks; `~/.config/noctalia/config.toml` is a symlink):

- Mango: `config.conf` sources `~/.config/mango/machine.conf`
  (`machines/laptop.conf` = trackpad + brightness keys + scroller-everywhere;
  `machines/desktop.conf` = scroller on ultrawide, tile on 1440p via
  `monitor_name:` tag rules — names are TODO placeholders until run on the desktop)
- Noctalia: `machines/laptop.toml` / `desktop.toml` each include `shared.toml`
- Alacritty: `alacritty.toml` imports `machine.toml` (font size per machine)
- Validate: `mango -c ~/.config/mango/config.conf -p`, `noctalia config validate`

## Live configs are symlinks into this repo

`~/.config/{alacritty,btop,zed,obsidian,mango,fish}` are **directory symlinks** to
`dotfiles/<app>`, and `~/.config/{hyfetch.json,mimeapps.list}` are file symlinks.
`~/.local/state/noctalia/settings.toml` is also a file symlink into the repo
(`dotfiles/noctalia/settings.toml` — the Settings GUI writes it and it wins over
the overlay TOMLs).
Editing `dotfiles/<app>/...` edits the live config directly — no copy step.

Caveats:
- **Directory** symlinks survive apps that save atomically (write temp file +
  rename): the replaced file lands inside the repo target dir.
- **File** symlinks (`hyfetch.json`, `mimeapps.list`,
  `~/.local/state/noctalia/settings.toml`) can be silently replaced
  by a real file when an app atomically rewrites them (e.g. `xdg-mime`,
  Noctalia Settings GUI). If a link disappears, restore it:
  `ln -sf ~/dots/dotfiles/<file> ~/.config/<file>`.
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
