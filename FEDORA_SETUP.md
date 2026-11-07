# Fedora Setup Guide

This guide explains how to recreate your NixOS Wayland desktop setup on Fedora without Nix.

## Overview

Your current setup uses:
- **Window Manager:** Niri
- **Status Bar:** Waybar
- **App Launcher:** Fuzzel
- **Notification Daemon:** Mako
- **Wallpaper Manager:** Waypaper (with `awww` backend)
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
sudo dnf install niri waybar fuzzel mako alacritty alacritty-terminfo \
                 waypaper awww zed-editor \
                 btop hyfetch qalculate-gtk \
                 steam slack discord signal-desktop \
                 tor-browser rpi-imager \
                 nautilus blueman pavucontrol networkmanager-applet \
                 pamixer playerctl brightnessctl wl-clipboard \
                 grim slurp swappy swaylock xdg-utils polkit-gnome \
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
# Waypaper (git version needed for `awww` backend)
sudo dnf groupinstall development-tools
sudo dnf install cairo-devel cairo-gobject-devel gobject-introspection-devel python3-devel
pipx install git+https://github.com/anufrievroman/waypaper

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
# Niri (compositor)
mkdir -p ~/.config/niri
cp dotfiles/niri/config.kdl ~/.config/niri/

# Waybar (status bar)
mkdir -p ~/.config/waybar
cp dotfiles/waybar/config ~/.config/waybar/config
cp dotfiles/waybar/style.css ~/.config/waybar/style.css

# Fuzzel (app launcher)
mkdir -p ~/.config/fuzzel
cp dotfiles/fuzzel/fuzzel.ini ~/.config/fuzzel/fuzzel.ini

# Mako (notifications)
mkdir -p ~/.config/mako
cp dotfiles/mako/config ~/.config/mako/config

# Alacritty (terminal)
mkdir -p ~/.config/alacritty
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```

### Wallpaper Config

```bash
# Waypaper
mkdir -p ~/.config/waypaper
cp dotfiles/waypaper/config.ini ~/.config/waypaper/config.ini
# Note: You may need to update paths in config.ini for your user
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

Create user systemd services for desktop session apps:

```bash
mkdir -p ~/.config/systemd/user
```

### Waybar Service

```ini
# ~/.config/systemd/user/waybar.service
[Unit]
Description=Waybar status bar
After=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/waybar
Restart=on-failure
RestartSec=2

[Install]
WantedBy=graphical-session.target
```

### Waypaper Service (restore wallpaper on login)

```ini
# ~/.config/systemd/user/waypaper.service
[Unit]
Description=Waypaper wallpaper restore
After=graphical-session.target
Wants=graphical-session.target

[Service]
Type=oneshot
ExecStart=/usr/bin/waypaper --restore

[Install]
WantedBy=graphical-session.target
```

### awww-daemon (wallpaper backend)

```ini
# ~/.config/systemd/user/awww-daemon.service
[Unit]
Description=awww wallpaper daemon
After=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/awww-daemon
Restart=on-failure
RestartSec=2

[Install]
WantedBy=graphical-session.target
```

### Enable Services

```bash
systemctl --user daemon-reload
systemctl --user enable waybar.service
systemctl --user enable waypaper.service
systemctl --user enable awww-daemon.service
systemctl --user start waybar.service
```

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

- `waybar/style.css` - Catppuccin Latte theme
- `fuzzel/fuzzel.ini` - Catppuccin colors
- `mako/config` - Catppuccin colors
- `alacritty/alacritty.toml` - Catppuccin Latte
- `btop/themes/catppuccin_frappe.theme` - Catppuccin Frappe

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
2. **Select Niri** at the login screen (if using GDM)
3. **Configure remaining settings** in each application

### Keyboard Shortcuts (Niri)

Your existing Niri config uses:

| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal |
| `Super + Space` | Open app launcher |
| `Super + Q` | Close window |
| `Super + Shift + E` | Quit Niri |
| `Super + Shift + /` | Show hotkey overlay |

## Troubleshooting

### Waybar Not Starting

```bash
# Check if waybar binary exists
which waybar

# Start manually to see errors
waybar
```

### Notifications Not Showing

```bash
# Ensure mako is running
pgrep -a mako

# Start mako if not running
mako
```

### Wallpaper Not Restoring

```bash
# Check waypaper service status
systemctl --user status waypaper

# Check awww-daemon status
systemctl --user status awww-daemon

# Test manually
waypaper --restore
```

### Niri Not Available at Login

```bash
# Ensure niri is installed
dnf list installed niri

# Check if niri session file exists
ls /usr/share/wayland-sessions/
```

### Problems with Specific Apps

- **Zed:** Use Flatpak if RPM isn't working
- **Obsidian:** Use Flatpak from Flathub
- **Teams for Linux:** Use RPM from teamsforlinux.de or Flatpak

## References

- [Niri Documentation](https://niri-wm.github.io/niri/)
- [Waybar GitHub](https://github.com/Alexays/Waybar)
- [Fuzzel GitHub](https://github.com/dnkl/fuzzel)
- [Mako GitHub](https://github.com/emersion/mako)
- [Waypaper GitHub](https://github.com/anufrievroman/waypaper)
- [Zed Installation](https://zed.dev/docs/installation)
- [Obsidian Installation](https://obsidian.md/help/install)
- [btop GitHub](https://github.com/Grtanner/btop)
- [Alacritty Website](https://alacritty.org)

## License

This guide is provided as-is. Configuration files are for personal use; review individual licenses for bundled applications.