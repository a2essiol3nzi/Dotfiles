#!/bin/sh

# in sway config there is its version
# Times the screen off and puts it to background
swayidle \
    timeout 5 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' &

# Locks the screen immediately
swaylock -c 65737e

# Kills last background task so idle timer doesn't keep running
kill %%
