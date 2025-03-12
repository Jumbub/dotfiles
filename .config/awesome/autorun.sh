#!/usr/bin/env zsh

run="$HOME/scripts/run-if-not"

# Blue light filter
$run --notify "redshift"

# Clipboard manager
$run --notify "greenclip daemon" "greenclip"
