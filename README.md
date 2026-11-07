# Dotfiles

Personal dotfiles for a modern Wayland desktop setup.

## Overview

This repository contains configuration files for:

### Core Desktop
- **Niri** — Scrollable tiling Wayland compositor
- **Waybar** — Customizable Wayland status bar
- **Fuzzel** — Wayland application launcher
- **Mako** — Lightweight Wayland notification daemon
- **Waypaper** — Wallpaper manager (with `awww` backend)
- **Zed** — Code editor settings
- **Obsidian** — Notes application settings
- **btop** — Process monitor
- **Alacritty** — Terminal emulator configuration

### Applications
- **Steam**, **Spotify**, **Tor Browser**, and many other applications

## Installation

### Fedora (recommended)

The easiest way to recreate this setup on Fedora is to follow the **[Fedora Setup Guide](FEDORA_SETUP.md)**.

### Other Linux Distros

The dotfiles are mostly distro-agnostic, but the waypaper `awww` backend may require additional setup depending on your distribution.

## Usage

### Manual Installation

```bash
git clone https://github.com/baustinlynch/dots ~/dots
cd ~/dots

# Copy configs
mkdir -p ~/.config/niri
cp dotfiles/niri/config.kdl ~/.config/niri/

mkdir -p ~/.config/waybar
cp dotfiles/waybar/config ~/.config/waybar/config
cp dotfiles/waybar/style.css ~/.config/waybar/style.css

mkdir -p ~/.config/fuzzel
cp dotfiles/fuzzel/fuzzel.ini ~/.config/fuzzel/fuzzel.ini

mkdir -p ~/.config/mako
cp dotfiles/mako/config ~/.config/mako/config

mkdir -p ~/.config/alacritty
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

mkdir -p ~/.config/waypaper
cp dotfiles/waypaper/config.ini ~/.config/waypaper/config.ini

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

### Catppuccin Theme

To apply the Catppuccin theme:

```bash
cp dotfiles/waybar/style.css ~/.config/waybar/
cp dotfiles/fuzzel/fuzzel.ini ~/.config/fuzzel/
cp dotfiles/mako/config ~/.config/mako/
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/
cp -r dotfiles/btop/themes/catppuccin_frappe.theme ~/.config/btop/themes/
```

## Customization

### Keybindings (Niri)

| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal (Alacritty) |
| `Super + Space` | Open app launcher (Fuzzel) |
| `Super + Q` | Close window |
| `Super + Shift + E` | Quit Niri |
| `Super + Shift + /` | Show hotkey overlay |

### Waybar Modules

The waybar status bar includes:
- Workspace and window title (`niri/workspaces`, `niri/window`)
- System status (volume, network, battery) via `pulseaudio`, `network`, `battery`
- Clock in center
- Custom power menu (`custom/power`)

## Reference

- [Niri Documentation](https://niri-wm.github.io/niri/)
- [Waybar GitHub](https://github.com/Alexays/Waybar)
- [Fuzzel GitHub](https://github.com/dnkl/fuzzel)
- [Mako GitHub](https://github.com/emersion/mako)
- [Waypaper GitHub](https://github.com/anufrievroman/waypaper)
- [Zed Website](https://zed.dev)
- [Obsidian Website](https://obsidian.md)
- [btop GitHub](https://github.com/Grtanner/btop)
- [Alacritty Website](https://alacritty.org)

## License

This repository contains configuration files for personal use.
