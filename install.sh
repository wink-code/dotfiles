#!/bin/bash
set -e

cd "$(dirname "$0")"

if ! command -v stow &>/dev/null; then
    echo "==> Installing GNU Stow..."
    sudo pacman -S --noconfirm stow
fi

echo "==> Backing up existing configs that would conflict..."
for pkg in hyprland terminal shell nvim yazi tools fcitx5 gtk opencode scripts wallpapers; do
    find "$pkg" -type f | while IFS= read -r file; do
        target="${file#$pkg/}"
        if [ -e "$HOME/$target" ] && [ ! -L "$HOME/$target" ]; then
            mkdir -p "$(dirname "$HOME/$target")"
            mv "$HOME/$target" "$HOME/$target.bak.$(date +%Y%m%d)"
            echo "  backed up: $target"
        fi
    done
done

echo "==> Stowing all packages..."
for pkg in hyprland terminal shell nvim yazi tools fcitx5 gtk opencode scripts wallpapers; do
    stow -R "$pkg"
    echo "  $pkg ✓"
done

echo ""
echo "==> Done! All dotfiles installed."
echo ""
echo "  Next steps:"
echo "  1. Restart your shell or run:  source ~/.zshrc"
echo "  2. Open Neovim and run:         :Lazy sync"
echo "  3. Install a Nerd Font:         sudo pacman -S ttf-jetbrains-mono-nerd"
echo "  4. Log out and back in (or reboot) for Hyprland session"
