#!/usr/bin/env zsh

run="$HOME/scripts/run-if-not"

$run "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1" "polkit-mate-aut"

$run --notify "start-pulseaudio-x11" "pulseaudio"
$run --notify "nm-applet"
$run --notify "pa-applet"

# File explorer GUI daemon
$run --notify "thunar --daemon" "thunar"

# Blue light filter
$run --notify "redshift"

# Clipboard manager
$run --notify "greenclip daemon" "greenclip"

# Entirely to make Rofi look cooler
$run --notify "picom"

