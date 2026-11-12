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
then copy the configs:

```bash
git clone https://github.com/baustinlynch/dots ~/dots
cd ~/dots

# Copy configs
mkdir -p ~/.config/mango
cp dotfiles/mango/config.conf dotfiles/mango/keybind.conf ~/.config/mango/
cp dotfiles/mango/mango-portals.conf ~/.config/xdg-desktop-portal/

# Archived niri config (deprecated, kept for reference)
# dotfiles/niri/*.kdl

mkdir -p ~/.config/alacritty
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

mkdir -p ~/.config/zed
cp dotfiles/zed/settings.json ~/.config/zed/settings.json

mkdir -p ~/.config/obsidian
cp dotfiles/obsidian/obsidian.json ~/.config/obsidian/obsidian.json

mkdir -p ~/.config/btop
cp dotfiles/btop/btop.conf ~/.config/btop/btop.conf
cp dotfiles/btop/themes/catppuccin_frappe.theme ~/.config/btop/themes/

# Copy desktop entry
mkdir -p ~/.local/share/applications
cp dotfiles/applications/dev.slick.Slick.desktop ~/.local/share/applications/
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
