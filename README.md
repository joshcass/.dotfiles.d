# .dotfiles.d/

Personal dotfiles and system setup for an Arch Linux + Sway (Wayland) desktop environment with Fish shell.

## Repository Structure

```
.dotfiles.d/
├── conf.d/            # Configuration files
│   ├── config/        # Symlinked to ~/.config/ (sway, waybar, fish, nvim, alacritty, etc.)
│   ├── home/          # Symlinked to ~/ as dotfiles (gitconfig, gitignore-global, pryrc, rspec)
│   └── local/         # Dark/light mode toggle scripts for darkman (alacritty, gtk, mako)
├── git/               # Git hooks (post-checkout, pre-push) and helper scripts (better-push, cleanup, email-guess)
├── scripts.d/         # Wrapper scripts for bemenu-run, chromium, slack
├── setup.d/           # Setup helpers: package lists, yay/fish/gpg install scripts
├── theming/           # Nordic GTK themes (submodules) and wallpaper
└── setup.sh           # Main bootstrap script
```

## What's Configured

- **Window manager:** Sway with swaylock, sworkstyle, and swayidle
- **Bar:** Waybar
- **Terminal:** Alacritty with Solarized dark/light themes
- **Shell:** Fish with pure prompt and z directory jumping
- **Editor:** Neovim (LazyVim) + Neovide
- **Notifications:** Mako
- **Audio:** PipeWire + PulseAudio + Bluetooth
- **Launcher:** bemenu
- **Screenshots:** grim + slurp + swappy
- **Color temperature:** Gammastep
- **Dark/light mode:** Darkman with per-app toggle scripts
- **Theme:** Nordic GTK (via git submodules)
- **Auth:** GPG + YubiKey (smartcard via pcscd)
- **Dev tools:** direnv, devbox, Nix, Docker Compose

## Setup

The setup script bootstraps a fresh Arch Linux install. Run it from any directory — it clones this repo to `~/.dotfiles.d` and handles the rest.

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/joshcass/.dotfiles.d/main/setup.sh)"
```

Or if you already have the repo cloned:

```sh
bash ~/.dotfiles.d/setup.sh
```

### What `setup.sh` does

1. Clones this repo to `~/.dotfiles.d`
2. Installs official Arch packages from `setup.d/packages.txt` via pacman
3. Installs yay (AUR helper) and AUR packages from `setup.d/aur.txt`
4. Updates pkgfile database
5. Installs Nix (Determinate Systems installer) and Devbox
6. Sets Fish as the default shell
7. Symlinks config files from `conf.d/home/` to `~/` and `conf.d/config/` to `~/.config/`
8. Configures GPG and YubiKey smartcard support
9. Enables systemd units
10. Initializes git submodules (Nordic themes, fish pure prompt, z)
11. Links Nordic themes to `/usr/share/themes/`
12. Prompts for a reboot
