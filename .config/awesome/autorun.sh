#!/usr/bin/env zsh

run="$HOME/scripts/run-if-not"

$run "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1" "polkit-mate-aut"

$run --notify "start-pulseaudio-x11" "pulseaudio"
$run --notify "xfsettingsd"
$run --notify "nm-applet"
$run --notify "msm_notifier"
$run --notify "pa-applet"

# File explorer GUI daemon
$run --notify "thunar --daemon" "thunar"

# Blue light filter
$run --notify "redshift"

# Clipboard manager
$run --notify "greenclip daemon" "greenclip"

# Transparency of windows
$run --notify "compton"

