# Fedora Setup Guide

This guide explains how to recreate your NixOS Wayland desktop setup on Fedora without Nix.

## Overview

Your current setup uses:
- **Window Manager:** Mango (replaced Niri on 2026-11-12)
- **Desktop Shell:** Noctalia (bar, launcher, notifications, wallpaper, lock screen, control center)
- **Terminal:** Alacritty
- **Editor:** Zed
- **Notes:** Obsidian

All of these are available on Fedora, though some require third-party repositories (COPR or Flatpak).

## Prerequisites

- Fedora Linux (Fedora 41+ recommended)
- Sudo access
- Internet connection

## Step 1: Enable RPM Fusion and Flatpak

Fedora doesn't include some proprietary software in its official repos. Enable RPM Fusion:

```bash
# RPM Fusion Free
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# RPM Fusion Non-free
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Enable Flatpak
sudo dnf install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

## Step 2: Install Core Packages

### From Official Fedora Repos

```bash
# Terra repository (hosts mangowm)
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

sudo dnf install mangowm noctalia alacritty alacritty-terminfo \
                 zed-editor \
                 btop hyfetch qalculate-gtk \
                 steam slack discord signal-desktop \
                 tor-browser rpi-imager \
                 nautilus pavucontrol \
                 wl-clipboard xdg-utils \
                 git curl wget htop ripgrep fd jq \
                 vim neovim gcc make cmake python3 nodejs go rustup \
                 qdirstat pandoc \
                 nerd-fonts.jetbrains-mono jetbrains-mono \
                 fontconfig noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji \
                 fish zsh bash
```

### From COPR (Third-party)

```bash
# Zen Browser
sudo dnf copr enable sneexy/zen-browser
sudo dnf install zen-browser

# OpenCode
sudo dnf copr enable sureclaw/opencode
sudo dnf install opencode
```

### From Flathub

```bash
# Obsidian (not in official repos)
flatpak install flathub md.obsidian.Obsidian

# Teams for Linux
flatpak install flathub com.github.IsmaelMartinez.teams_for_linux

# Alternative: Zen Browser from Flathub
flatpak install flathub org.mozilla.zen-browser

# Alternative: Zed from Flathub
flatpak install flathub dev.zed.Zed
```

### From Git/Pip

```bash
# Teams for Linux RPM (alternative to Flatpak)
curl -fsSL https://repo.teamsforlinux.de/install.sh | sudo bash

# Hermes Agent (if you used it on NixOS)
# Check for official releases or build from source
curl -fsSL https://opencode.ai/v2/install | bash
```

## Step 3: Configure Dotfiles

Clone the dotfiles repository and link the configs:

```bash
git clone https://github.com/baustinlynch/dots ~/dots
cd ~/dots
```

### Core Desktop Configs

```bash
# Mango (compositor) + Noctalia keybinds
mkdir -p ~/.config/mango ~/.config/xdg-desktop-portal ~/.config/noctalia
cp dotfiles/mango/mango-portals.conf ~/.config/xdg-desktop-portal/
# Machine overlay symlinks (laptop profile shown; use desktop.* for the desktop)
ln -s machines/laptop.conf ~/dots/dotfiles/mango/machine.conf
ln -s machines/laptop.toml ~/dots/dotfiles/alacritty/machine.toml
ln -s ~/dots/dotfiles/noctalia/machines/laptop.toml ~/.config/noctalia/config.toml
# Noctalia keeps its settings in ~/.config/noctalia/ (created on first run)

# Alacritty (terminal)
mkdir -p ~/.config/alacritty
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```

### Editor & Notes Config

```bash
# Zed editor
mkdir -p ~/.config/zed
cp dotfiles/zed/settings.json ~/.config/zed/settings.json

# Obsidian
mkdir -p ~/.config/obsidian
cp dotfiles/obsidian/obsidian.json ~/.config/obsidian/obsidian.json
# Note: Update vault paths in obsidian.json if needed
```

### btop (system monitor)

```bash
mkdir -p ~/.config/btop
cp dotfiles/btop/btop.conf ~/.config/btop/btop.conf
cp dotfiles/btop/themes/catppuccin_frappe.theme ~/.config/btop/themes/
```

### System-level Config

```bash
# MIME types
cp dotfiles/mimeapps.list ~/.config/

# Desktop entries
mkdir -p ~/.local/share/applications
cp dotfiles/applications/dev.slick.Slick.desktop ~/.local/share/applications/
```

## Step 4: Systemd User Services

No manual user services are needed. Noctalia is spawned at startup by mango
(`exec_once=noctalia` in `~/.config/mango/config.conf`), and optionally
managed as a systemd user unit — see the
[Noctalia systemd service docs](https://docs.noctalia.dev/noctalia/compositor-settings/systemd-service/).
Noctalia also handles wallpaper, notifications, the bar, the launcher, and the
lock screen itself, so no waybar/waypaper/awww/mako services are required.

## Step 5: Network Configuration

### DNS Bypass Script (School Network)

If you were using the school DNS bypass script:

```bash
sudo cp hosts/laptop/scripts/school-dns-bypass.sh /etc/NetworkManager/dispatcher.d/00-school-dns-bypass
sudo chmod +x /etc/NetworkManager/dispatcher.d/00-school-dns-bypass
```

Edit the script to match your WiFi interface name (run `nmcli device status` to find it).

### Touchpad Quirks

For Dell Inspiron 3525 touchpad:

```bash
sudo mkdir -p /etc/libinput/local-overrides.quirks.d/
sudo cp dotfiles/touchpad/quirks /etc/libinput/local-overrides.quirks.d/10-dell-touchpad.quirks
sudo systemctl restart systemd-localed
```

(Note: Create the quirks file based on your NixOS touchpad config if needed.)

## Step 6: Fonts & Themes

### Install Fonts

```bash
# JetBrains Mono Nerd Font
sudo dnf install nerd-fonts.jetbrains-mono

# Additional fonts
sudo dnf install noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji
```

### Apply Catppuccin Theme

Your configs already use Catppuccin colors:

- `alacritty/alacritty.toml` - Catppuccin Latte
- `btop/themes/catppuccin_frappe.theme` - Catppuccin Frappe

Noctalia provides its own theming: choose a palette in Settings → Theme, or
generate one from your wallpaper (see
[theming docs](https://docs.noctalia.dev/noctalia/theming/)).

## Step 7: Terminal & Shell

### Fish Shell

If you were using fish on NixOS:

```bash
sudo dnf install fish
chsh -s /usr/bin/fish
```

Copy any fish config from your previous setup:

```bash
mkdir -p ~/.config/fish
# Copy fish config files
```

## Step 8: Additional Applications

### Hermes Agent

If you used Hermes Agent on NixOS:

```bash
# Check if available via pip or direct download
pip install hermes-agent
# Or check https://github.com/NousResearch/hermes-agent for installation instructions
```

### Other Missing Apps

| App | NixOS | Fedora Equivalent |
|-----|-------|-------------------|
| zen-beta | zen-browser COPR | zen-browser (dnf) |
| obsidian | Flatpak | Flatpak |
| teams-for-linux | Flatpak/RPM | Flatpak/RPM |
| opencode | COPR | COPR |
| qcalc | Not packaged | qalculate-gtk |
| nil | dnf | nil |
| nixd | dnf | nixd |
| lunar-client | dnf | dnf |

## Step 9: Final Steps

1. **Log out and log back in** to apply user systemd services
2. **Select Mango** at the login screen (if using GDM)
3. **Configure remaining settings** in each application

### Keyboard Shortcuts (Mango)

Your existing Mango config uses:

| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal |
| `Super + Space` | Open Noctalia launcher |
| `Super + S` | Open Noctalia control center |
| `Super + Shift + ,` | Open Noctalia settings |
| `Alt + Tab` | Noctalia window switcher |
| `Super + Q` | Close window |
| `Super + Shift + E` | Quit Mango |
| `Super + 1..9` | View tag |
| `Super + W` | Cycle layout |

## Troubleshooting

### Noctalia Not Starting

```bash
# Check if the binary exists
which noctalia

# Start manually to see errors
NOCTALIA_LOG_LEVEL=debug noctalia
```

### Notifications Not Showing

```bash
# Ensure Noctalia is running (it owns the notification daemon)
pgrep -a noctalia

# Verify no other notification daemon is running
pgrep -a mako
```

### Wallpaper Not Showing

```bash
# Set a wallpaper via IPC
noctalia msg wallpaper-set ~/Pictures/Background/wallpaper.png

# Or pick one in the settings GUI
noctalia msg settings-toggle
```

### Mango Not Available at Login

```bash
# Ensure mango is installed
dnf list installed mangowm

# Check if the mango session file exists
ls /usr/share/wayland-sessions/mango.desktop
```

### Problems with Specific Apps

- **Zed:** Use Flatpak if RPM isn't working
- **Obsidian:** Use Flatpak from Flathub
- **Teams for Linux:** Use RPM from teamsforlinux.de or Flatpak

## References

- [Mango Documentation](https://mangowm.github.io/docs/)
- [Noctalia Documentation](https://docs.noctalia.dev/noctalia/)
- [Zed Installation](https://zed.dev/docs/installation)
- [Obsidian Installation](https://obsidian.md/help/install)
- [btop GitHub](https://github.com/Grtanner/btop)
- [Alacritty Website](https://alacritty.org)

## License

This guide is provided as-is. Configuration files are for personal use; review individual licenses for bundled applications.