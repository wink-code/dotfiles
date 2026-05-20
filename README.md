# dotfiles

Personal desktop environment dotfiles for Arch Linux + Hyprland.

Managed with **GNU Stow** — change your config, `git diff` sees it immediately.

## Packages

| Stow package | Contents |
|---|---|
| `hyprland` | Hyprland WM, waybar, wofi, dunst, wlogout, uwsm |
| `terminal` | kitty + alacritty |
| `shell` | .zshrc, .bashrc, .profile, .zprofile, .gitconfig, motd |
| `nvim` | Neovim (lazy.nvim + 12 plugins, catppuccin theme) |
| `yazi` | Yazi file manager |
| `tools` | fastfetch, btop, lazygit, ncspot, Thunar |
| `fcitx5` | Chinese input method |
| `gtk` | GTK3 settings + fontconfig |
| `opencode` | OpenCode AI assistant config |
| `scripts` | Custom scripts (screenshot, volume, brightness, etc.) |
| `wallpapers` | 16 wallpapers |

## Prerequisites

Arch Linux with `base-devel` installed.

## Install

### 1. Clone

```bash
git clone https://github.com/johnwink/dotfiles.git ~/dotfiles
```

### 2. Install dependencies

```bash
sudo pacman -S --needed \
  hyprland hyprpaper hypridle hyprlock hyprlauncher uwsm \
  waybar wofi wlogout kitty alacritty \
  dunst libnotify \
  fcitx5 fcitx5-chinese-addons fcitx5-configtool \
  neovim git lazygit btop fastfetch \
  yazi thunar ffmpegthumbnailer poppler unrar p7zip fd ripgrep \
  ncspot playerctl \
  grim slurp wl-clipboard \
  pipewire wireplumber pavucontrol \
  brightnessctl upower \
  networkmanager network-manager-applet blueman \
  fzf shellcheck ruff python gcc \
  gtk3 stow \
  ttf-jetbrains-mono-nerd noto-fonts-cjk
```

### 3. Stow

```bash
cd ~/dotfiles
./install.sh
```

Or selectively:

```bash
stow hyprland terminal shell nvim yazi tools fcitx5 gtk opencode scripts wallpapers
```

### 4. Post-install

```bash
# Restart shell
source ~/.zshrc

# First Neovim launch — lazy.nvim auto-installs, then run:
nvim +Lazy sync

# Log out / reboot to start Hyprland via uwsm
```

## Usage

### Daily workflow

Configs are symlinked — edit in place, changes appear in the repo:

```bash
vim ~/.config/hypr/hyprland.conf
cd ~/dotfiles
git diff
git commit -am "update hypr keybinds"
git push
```

### Selective install (different machines)

| Scenario | Command |
|---|---|
| Minimal server | `stow shell nvim` |
| Desktop (no Chinese input) | `stow hyprland terminal shell nvim yazi tools gtk scripts wallpapers` |
| Full desktop | `stow hyprland terminal shell nvim yazi tools fcitx5 gtk opencode scripts wallpapers` |

### Stow tips

```bash
# Preview what would change (dry-run)
stow --no -v hyprland

# Remove a package's symlinks
stow -D hyprland

# Restow (update) a package
stow -R hyprland
```

## Notes

- **Neovim**: Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim). First launch auto-clones it. `lazy-lock.json` tracks exact plugin versions. See [nvim shortcuts](documents/nvim-shortcuts.md) for keybindings.
- **Wallpapers**: Stored in `~/imgs/desktop/`. The `wallpaper-cycle.sh` / `wallpaper-restore.sh` scripts reference this path.
- **Hyprland session**: `.profile` auto-starts Hyprland via `uwsm`. Remove the `exec uwsm` line if you use a display manager.
- **Fcitx5**: Chinese input method. Set up with `fcitx5-configtool` after install.
- **Git config**: `.gitconfig` contains personal email — update before use.
- **NuPhy keyboard**: `nuphy-fix.py` is **not** included (hardware-specific). Copy it separately if needed from `~/.local/bin/`.
- **OpenCode**: Only `opencode.jsonc` is tracked, not `node_modules/`.
