#!/bin/bash

# Entra nella cartella wallpapers
cd "$(dirname "$0")/wallpapers" || { echo "Cartella wallpapers non trovata!"; exit 1; }

echo "--- Ottimizzazione Sfondi (PNG -> JPG 90%) ---"

# Trova tutti i file PNG, JPG, JPEG più grandi di 50MB
find . -maxdepth 1 -type f -size +50M \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r file; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    name="${filename%.*}"
    
    echo "Rilevato file pesante (>50MB): $filename"
    echo "  -> Ottimizzo..."
    
    # Converte/Comprime in JPG con qualità 90% e rimuove metadati (-strip)
    magick "$file" -quality 90 -strip -interlace Plane "$name.jpg"
    
    if [ $? -eq 0 ]; then
        echo "  -> Ottimizzato in $name.jpg"
        # Se l'originale non era già il file .jpg appena creato, lo elimina
        if [ "$file" != "./$name.jpg" ]; then
            rm "$file"
        fi
    else
        echo "  [ERRORE] Impossibile processare $filename"
    fi
done

echo "--- Finito! ---"
