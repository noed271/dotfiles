#!/usr/bin/env bash
# Symlink every package into $HOME via GNU Stow.
# --no-folding keeps real directories so app/matugen runtime files don't land in the repo.
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")"

command -v stow >/dev/null || { echo "stow not installed: sudo pacman -S --needed stow"; exit 1; }

PKGS=(hypr waybar rofi kitty swaync dunst wofi btop cava fastfetch nvim yazi wal matugen wallpapers localbin starship)

for p in "${PKGS[@]}"; do
  [ -d "$p" ] || { echo "skip (missing): $p"; continue; }
  stow --no-folding -t "$HOME" "$p" && echo "stowed: $p"
done

# keyd lives under /etc, so it stows into / with root instead of $HOME.
if [ -d keyd ]; then
  sudo stow --no-folding -t / keyd && echo "stowed (root): keyd"
  sudo systemctl reload keyd 2>/dev/null || true
fi

# Seed the untracked mode pointer (Normal) if missing, so hyprland.conf's
# `source = ~/.config/hypr/current-mode.conf` resolves on a fresh machine.
PTR="$HOME/.config/hypr/current-mode.conf"
[ -e "$PTR" ] || echo "source = ~/.config/hypr/hyprland-gui.conf" > "$PTR"

echo "Done. Regenerate colors with: matugen image ~/.config/wallpapers/<file>"
