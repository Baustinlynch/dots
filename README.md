# Dotfiles

Personal dotfiles for a modern Wayland desktop setup.

## Overview

This repository contains configuration files for:

### Core Desktop
- **Mango** — Lightweight tag-based Wayland compositor (replaced Niri on 2026-11-12)
- **Noctalia** — Desktop shell: bar, launcher, notifications, wallpaper, lock screen, control center
- **Zed** — Code editor settings
- **Obsidian** — Notes application settings
- **btop** — Process monitor
- **Alacritty** — Terminal emulator configuration
- **Fish** — Shell config (`config.fish`, `conf.d/`, completions; `fish_variables` is gitignored state)

### Applications
- **Steam**, **Spotify**, **Tor Browser**, and many other applications

> [!NOTE]
> Noctalia replaced the old **Waybar / Fuzzel / Mako / Waypaper** stack on
> [2026-11-08](https://docs.noctalia.dev/noctalia/). The legacy configs under
> `dotfiles/waybar`, `dotfiles/fuzzel`, `dotfiles/mako`, and `dotfiles/waypaper`
> are kept only for reference.

## Installation

### Fedora (recommended)

The easiest way to recreate this setup on Fedora is to follow the **[Fedora Setup Guide](FEDORA_SETUP.md)**.

First install the desktop packages (see the [Fedora Setup Guide](FEDORA_SETUP.md)),
then symlink the configs (live configs link into the repo — edits apply instantly):

```bash
git clone https://github.com/Baustinlynch/dots ~/dots
cd ~/dots

# Symlink app config dirs
ln -s ~/dots/dotfiles/alacritty ~/.config/alacritty
ln -s ~/dots/dotfiles/btop      ~/.config/btop
ln -s ~/dots/dotfiles/zed       ~/.config/zed
ln -s ~/dots/dotfiles/obsidian  ~/.config/obsidian
ln -s ~/dots/dotfiles/mango     ~/.config/mango
ln -s ~/dots/dotfiles/fish      ~/.config/fish

# Symlink single files
ln -s ~/dots/dotfiles/hyfetch.json  ~/.config/hyfetch.json
ln -s ~/dots/dotfiles/mimeapps.list ~/.config/mimeapps.list

# Portals config (plain copy, not linked)
mkdir -p ~/.config/xdg-desktop-portal
cp dotfiles/mango/mango-portals.conf ~/.config/xdg-desktop-portal/

# Machine overlay: pick this machine's profile
ln -s machines/laptop.conf  ~/dots/dotfiles/mango/machine.conf
ln -s machines/laptop.toml  ~/dots/dotfiles/alacritty/machine.toml

# Noctalia machine profile
mkdir -p ~/.config/noctalia
ln -s ~/dots/dotfiles/noctalia/machines/laptop.toml ~/.config/noctalia/config.toml

# Archived niri config (deprecated, kept for reference)
# dotfiles/niri/*.kdl

# Desktop entry is installed system-wide by the Slick package
# (dotfiles/applications/ is reference only)
```

Noctalia keeps GUI overrides in `~/.local/state/noctalia/settings.toml`
(written by the Settings GUI; those win over the files above).

## Machine variants

Per-machine settings live in `machines/` overlays selected by a symlink:

| App | Shared | Machine overlays | Selector (gitignored) |
|-----|--------|------------------|-----------------------|
| Mango | `dotfiles/mango/config.conf`, `keybind.conf` | `machines/laptop.conf`, `machines/desktop.conf` | `~/.config/mango/machine.conf` symlink (also lives at `dotfiles/mango/machine.conf`) |
| Noctalia | `dotfiles/noctalia/shared.toml` | `machines/laptop.toml`, `machines/desktop.toml` | `~/.config/noctalia/config.toml` symlink |
| Alacritty | `dotfiles/alacritty/alacritty.toml` | `machines/laptop.toml`, `machines/desktop.toml` | `dotfiles/alacritty/machine.toml` symlink |

Laptop = single display, scroller everywhere, trackpad,
brightness keys, font 10.5
Desktop = 1440p 4:3 OLED + 1080p ultrawide: scroller on the ultrawide (main),
tile on the 1440p, no trackpad/brightness, font 13. To switch a machine's
profile, point its `machine.*` symlink at the other overlay.
```

Noctalia keeps its own settings in `~/.config/noctalia/` (created on first run).

### Catppuccin Theme

To apply the Catppuccin theme:

```bash
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/
cp -r dotfiles/btop/themes/catppuccin_frappe.theme ~/.config/btop/themes/
```

(Noctalia provides its own theming — palette and wallpaper theming are handled
in `noctalia` Settings; see https://docs.noctalia.dev/noctalia/theming/.)

## Customization

### Keybindings (Mango)

Keybinds mirror the old Niri setup; tags replace workspaces and the scroller
layout replaces scrollable columns:

| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal (Alacritty) |
| `Super + Space` | Open Noctalia launcher |
| `Super + S` | Open Noctalia control center |
| `Super + Shift + ,` | Open Noctalia settings |
| `Alt + Tab` | Noctalia window switcher |
| `Super + Shift + S` | Screenshot with annotate editor |
| `Super + Alt + L` | Lock screen |
| `Super + Q` | Close window |
| `Super + Shift + E` | Quit Mango |
| `Super + 1..9` | View tag 1..9 |
| `Super + Ctrl + 1..9` | Move window to tag 1..9 |
| `Super + W` | Cycle layout (tile/scroller/monocle/deck) |

### Noctalia

Noctalia's settings GUI (`Super + Shift + ,`) manages the bar widgets, wallpaper,
notifications, and theming without editing config files. TOML settings live at
`~/.config/noctalia/settings.toml` (a full annotated example is available in the
[documentation](https://docs.noctalia.dev/noctalia/configuration/)).

## Reference

- [Mango Documentation](https://mangowm.github.io/docs/)
- [Noctalia Mango Setup](https://docs.noctalia.dev/noctalia/compositor-settings/mango/)
- [Zed Website](https://zed.dev)
- [Obsidian Website](https://obsidian.md)
- [btop GitHub](https://github.com/Grtanner/btop)
- [Alacritty Website](https://alacritty.org)

## License

This repository contains configuration files for personal use.
