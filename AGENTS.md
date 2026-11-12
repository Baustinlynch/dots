# AGENTS.md

Guidance for AI agents working in this dotfiles repo.

## Layout

- `dotfiles/` — canonical config sources, organized per app
- `dotfiles/mango/` — compositor config (`config.conf`, `keybind.conf`) + `mango-portals.conf`
- `dotfiles/niri/` — **archived**, do not edit or "modernize" (see `DEPRECATED.md`)
- `dotfiles/waybar|fuzzel|mako|waypaper/` — legacy reference only; replaced by Noctalia shell
- `FEDORA_SETUP.md` — full machine rebuild guide

## Live configs are copies, not symlinks

`~/.config/<app>` contains **plain copies** of `dotfiles/<app>` — nothing is
symlinked. After editing anything under `dotfiles/`, copy it to the live
location or the change does nothing:

```bash
cp dotfiles/mango/config.conf dotfiles/mango/keybind.conf ~/.config/mango/
```

The reverse matters too: live configs can drift (GUI tools rewrite them).
Before editing, diff against the repo copy and port live changes back.

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
