#!/bin/sh

# Avvia swayidle in background.
# -w: attende che il comando termini
# timeout 5: dopo 5 secondi di inattività (mentre sei bloccato), spegne i monitor.
# resume: quando muovi il mouse, riaccende i monitor.
swayidle -w \
    timeout 5 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' &

# Salva il PID dell'ultimo processo in background (swayidle)
IDLE_PID=$!

# Blocca lo schermo immediatamente.
# Lo script si ferma qui finché non inserisci la password.
swaylock -c 65737e

# Appena sbloccato (swaylock termina), uccidi il processo swayidle
kill $IDLE_PID