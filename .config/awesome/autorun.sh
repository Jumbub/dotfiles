#!/usr/bin/env zsh

run="$HOME/scripts/run-if-not"

# Audio manager
$run --notify "start-pulseaudio-x11" "pulseaudio"

# Blue light filter
$run --notify "redshift"

# Clipboard manager
$run --notify "greenclip daemon" "greenclip"

# Bluetooth
$run --notify "blueman-applet"
