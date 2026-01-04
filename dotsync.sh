#!/bin/bash

# working dir
REPO_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"

# config dirs in .config
CONFIG_APPS=("helix" "sway" "tofi" "waybar" "fontconfig" "tmux" "fastfetch" "alacritty")

# SUCKLESS_APPS=("dwm" "dmenu" "slock" "slstatus")

echo "--- Sincronizzazione Dotfiles (.config -> Repo) ---"

for app in "${CONFIG_APPS[@]}"; do
    if [ -d "$CONFIG_DIR/$app" ]; then
        echo "Sincronizzo $app..."
        # Usiamo rsync per copiare solo i file diversi ed eliminare quelli rimossi nella sorgente
        rsync -av --delete --exclude 'plugins' "$CONFIG_DIR/$app/" "$REPO_DIR/$app/"
    else
        echo "Attenzione: $CONFIG_DIR/$app non trovata. Salto."
    fi
done

echo "--- Sincronizzazione completata! ---"
