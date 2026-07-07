#!/bin/sh

grim -g "$(slurp)" - | tee "$HOME/Pictures/Screenshots/scrt-$(date +'%Y-%m-%d_%H-%M-%S').png" | wl-copy
