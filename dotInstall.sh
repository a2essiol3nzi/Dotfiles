#!/bin/bash

# repo dir
REPO_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="./config-backup-$(date +%Y%m%d-%H%M%S)"

# dir not to link in .config
EXCLUDE=("images" "wallpapers" "dwm" "st" "dmenu" "slock" "slstatus" ".git")

echo "--- Installazione Dotfiles Dinamica ---"
echo "Backup Directory: $BACKUP_DIR"
echo ""

# all dir in repo except the exluded once
for app in */; do
    app=${app%/} # Rimuove lo slash finale
    
    if [[ " ${EXCLUDE[@]} " =~ " ${app} " ]]; then
        echo "[SKIP] $app (esclusa)"
        continue
    fi

    source="$REPO_DIR/$app"
    target="$CONFIG_DIR/$app"

    echo "[LINKING] $app..."

    # Gestione backup
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ] && [ "$(readlink -f "$target")" == "$source" ]; then
            echo "  Already linked."
            continue
        fi
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/$app"
        echo "  Existing config backed up."
    fi

    # Crea il link
    ln -s "$source" "$target"
    echo "  Link created: $target -> $source"
done

echo ""
echo "--- Done! ---"
